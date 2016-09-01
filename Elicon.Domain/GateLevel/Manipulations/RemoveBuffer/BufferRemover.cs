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
        private readonly IPassThroughBufferVerifier _passThroughBufferVerifier;
        private readonly IInstanceMutator _instanceMutator;

        public BufferRemover(IInstanceMutator instanceMutator, IInstanceRepository instanceRepository, IPassThroughBufferVerifier passThroughBufferVerifier)
        {
            _instanceMutator = instanceMutator;
            _instanceRepository = instanceRepository;
            _passThroughBufferVerifier = passThroughBufferVerifier;
        }

        public void Remove(string netlist, string bufferName, string inputPort, string outputPort)
        {
            var buffers = _instanceRepository.GetByModuleName(netlist, bufferName);

            foreach (var buffer in buffers)
            {
               if (_passThroughBufferVerifier.IsPassThroughBuffer(buffer, inputPort, outputPort))
                    continue;

                _instanceRepository.Remove(buffer);

                var oldWire = buffer.GetWire(inputPort);
                var newWire = buffer.GetWire(outputPort);
                var instances = _instanceRepository.GetByHostModule(buffer.Netlist, buffer.HostModuleName).ToList();

               _instanceMutator.Take(instances).ReplaceWires(oldWire, newWire);
               _instanceRepository.Update(instances);
            }
        }
    }
}