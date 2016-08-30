using System.Collections.Generic;
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
        private readonly IInstanceWiresReplacer _instanceWiresReplacer;

        public BufferRemover(IInstanceRepository instanceRepository, IPassThroughBufferVerifier passThroughBufferVerifier, IInstanceWiresReplacer instanceWiresReplacer)
        {
            _instanceRepository = instanceRepository;
            _passThroughBufferVerifier = passThroughBufferVerifier;
            _instanceWiresReplacer = instanceWiresReplacer;
        }

        public void Remove(string netlist, string bufferName, string inputPort, string outputPort)
        {
            var buffers = _instanceRepository.GetByModuleName(netlist, bufferName);

            foreach (var buffer in buffers)
            {
               if (_passThroughBufferVerifier.IsPassThroughBuffer(buffer, inputPort, outputPort))
                    continue;

                var wiresMap = new Dictionary<string, string> {{buffer.GetWire(inputPort), buffer.GetWire(outputPort)}};
                var instances = _instanceRepository.GetByHostModule(netlist, buffer.HostModuleName);
                foreach (var instance in instances)
                    _instanceWiresReplacer.ReplaceWires(instance, wiresMap);
                
                _instanceRepository.Remove(buffer);
            }
        }
    }
}