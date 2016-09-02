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

        public BufferRemover(IInstanceMutator instanceMutator, IInstanceRepository instanceRepository, IBufferWiringVerifier bufferWiringVerifier)
        {
            _instanceMutator = instanceMutator;
            _instanceRepository = instanceRepository;
            _bufferWiringVerifier = bufferWiringVerifier;
        }

        public void Remove(string netlist, string bufferName, string inputPort, string outputPort)
        {
            var buffers = _instanceRepository.GetByModuleName(netlist, bufferName);

            foreach (var buffer in buffers)
            {
                var bufferWiring = _bufferWiringVerifier.Verify(buffer, inputPort, outputPort);
                if (bufferWiring == BufferWiring.PassThroughBuffer)
                    continue;

                _instanceRepository.Remove(buffer);

                var instances = _instanceRepository.GetByHostModule(buffer.Netlist, buffer.HostModuleName).ToList();
                if (bufferWiring == BufferWiring.DrivenByHostModule)
                {
                    var modulePort = buffer.GetWire(inputPort);
                    var bufferOutputWire = buffer.GetWire(outputPort);
                    _instanceMutator.Take(instances).ReplaceWires(bufferOutputWire, modulePort);
                }
                else 
                {
                    var oldWire = buffer.GetWire(inputPort);
                    var newWire = buffer.GetWire(outputPort);
                    _instanceMutator.Take(instances).ReplaceWires(oldWire, newWire);
                }
                   
               _instanceRepository.Update(instances);
            }
        }
    }
}