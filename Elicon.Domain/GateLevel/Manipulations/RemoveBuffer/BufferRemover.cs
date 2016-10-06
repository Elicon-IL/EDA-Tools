using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
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
        private readonly IOpenOutputModuleRemover _openOutputModuleRemover;

        public BufferRemover(IInstanceMutator instanceMutator, IInstanceRepository instanceRepository, IBufferWiringVerifier bufferWiringVerifier, IModuleRepository moduleRepository, IOpenOutputModuleRemover openOutputModuleRemover)
        {
            _instanceMutator = instanceMutator;
            _instanceRepository = instanceRepository;
            _bufferWiringVerifier = bufferWiringVerifier;
            _moduleRepository = moduleRepository;
            _openOutputModuleRemover = openOutputModuleRemover;
        }

        public void Remove(string netlist, string bufferName, string inputPort, string outputPort)
        {
            _openOutputModuleRemover.Remove(netlist, bufferName, outputPort);

            Parallel.ForEach(_moduleRepository.GetAll(netlist), module => 
                RemoveBuffers(module, bufferName, inputPort, outputPort)
            );
        }

        private void RemoveBuffers(Module module, string bufferName, string inputPort, string outputPort)
        {
            var bufferIdsToBuffersMap = _instanceRepository.GetByHostModule(module.Netlist, module.Name)
                 .Where(i => i.ModuleName == bufferName)
                 .ToDictionary(i => i.Id, i => i);

            foreach (var bufferId in bufferIdsToBuffersMap.Keys.ToList())
            {
                var buffer = bufferIdsToBuffersMap[bufferId];
                if (_bufferWiringVerifier.IsPassThroughBuffer(module, buffer, inputPort, outputPort))
                    continue;

                _instanceRepository.Remove(buffer);

                var buffersToUpdate = ReplaceWires(module, inputPort, outputPort, buffer);
                foreach (var bufferToUpdate in buffersToUpdate)
                    bufferIdsToBuffersMap[bufferToUpdate.Id] = bufferToUpdate;
            }
        }

        private List<Instance> ReplaceWires(Module module, string inputPort, string outputPort, Instance buffer)
        {
            var instances = _instanceRepository.GetByHostModule(module.Netlist, module.Name);

            if (_bufferWiringVerifier.HostModuleDrivesBuffer(module, buffer, inputPort))
                _instanceMutator.Take(instances).ReplaceWires(buffer.GetWire(outputPort), buffer.GetWire(inputPort));
            else
                _instanceMutator.Take(instances).ReplaceWires(buffer.GetWire(inputPort), buffer.GetWire(outputPort));

            _instanceRepository.UpdateMany(instances);

            return instances.Where(instance => instance.ModuleName == buffer.ModuleName).ToList();
        }
    }
}