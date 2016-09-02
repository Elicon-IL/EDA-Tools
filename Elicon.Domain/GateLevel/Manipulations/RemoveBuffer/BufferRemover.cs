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
            Instance buffer;
            while (TryGetBufferToRemove(netlist, bufferName, inputPort, outputPort, out buffer))
            {
                _instanceRepository.Remove(buffer);

                var instances = _instanceRepository.GetByHostModule(buffer.Netlist, buffer.HostModuleName).ToList();
                if (_bufferWiringVerifier.BufferIsDrivenByHostModule(buffer, inputPort))
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

                _instanceRepository.Update(instances);
            }
        }
        
        private bool TryGetBufferToRemove(string netlist, string bufferName, string inputPort, string outputPort, out Instance buffer)
        {
            buffer = _instanceRepository
                .GetByModuleName(netlist, bufferName)
                .FirstOrDefault(b => _bufferWiringVerifier.NotPassThroughBuffer(b, inputPort, outputPort));
            
            return buffer != null;
        }
    }
}