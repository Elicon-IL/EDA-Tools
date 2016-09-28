using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.RemoveBuffer
{
    public interface IBufferRemover
    {
        void Remove(string netlist, string bufferName, string inputPort, string outputPort);
    }

    public class BufferRemover : IBufferRemover
    {
        private readonly IInstanceRepository _instanceRepository;
        private readonly IBufferWiringVerifier _bufferWiringVerifier;
        private readonly IInstanceMutator _instanceMutator;
        private readonly IModuleRepository _moduleRepository;

        public BufferRemover(IInstanceMutator instanceMutator, IInstanceRepository instanceRepository, IBufferWiringVerifier bufferWiringVerifier, IModuleRepository moduleRepository)
        {
            _instanceMutator = instanceMutator;
            _instanceRepository = instanceRepository;
            _bufferWiringVerifier = bufferWiringVerifier;
            _moduleRepository = moduleRepository;
        }

        public void Remove(string netlist, string bufferName, string inputPort, string outputPort)
        {
            var buffers = _instanceRepository.GetByModuleName(netlist, bufferName);
            var buffersMapping = buffers.Select((b, i) => new {Index = i, Buffer = b})
                .ToDictionary(el => el.Buffer.Id, el => el.Index);

            var hostsMap = _moduleRepository
                .GetMany(netlist, buffers.Select(b => b.HostModuleName).ToList())
                .ToDictionary(m => m.Name, m => m);

            foreach (var buffer in buffers)
            {
                var hostModule = hostsMap[buffer.HostModuleName];
                if (_bufferWiringVerifier.IsPassThroughBuffer(hostModule, buffer, inputPort, outputPort))
                    continue;

                _instanceRepository.Remove(buffer);
                if (buffer.HasPort(outputPort))
                    ReplaceWires(hostModule, buffer, inputPort, outputPort, buffers, buffersMapping);
            }
        }

        private void ReplaceWires(Module hostModule, Instance buffer, string inputPort, string outputPort, IList<Instance> buffers, Dictionary<long, int> buffersMapping)
        {
            var instances = _instanceRepository.GetByHostModule(buffer.Netlist, buffer.HostModuleName).ToList();
            if (_bufferWiringVerifier.HostModuleDrivesBuffer(hostModule, buffer, inputPort))
            {
                var moduleInputPort = buffer.GetWire(inputPort);
                var bufferOutputWire = buffer.GetWire(outputPort);
                _instanceMutator.Take(instances).ReplaceWires(bufferOutputWire, moduleInputPort);
            }
            else
            {
                var oldWire = buffer.GetWire(inputPort);
                var newWire = buffer.GetWire(outputPort);
                _instanceMutator.Take(instances).ReplaceWires(oldWire, newWire);
            }

            _instanceRepository.UpdateMany(instances);
            UpdateLocalBufferList(buffer, instances, buffers, buffersMapping);
        }

        private void UpdateLocalBufferList(Instance buffer, List<Instance> instances, IList<Instance> buffers, Dictionary<long, int> buffersMapping)
        {
            foreach (var instance in instances.Where(instance => instance.ModuleName == buffer.ModuleName))
                buffers[buffersMapping[instance.Id]] = instance;

        }
    }
}