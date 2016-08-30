using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.RemoveBuffer
{
    public interface IPassThroughBufferVerifier
    {
        bool IsPassThroughBuffer(Instance buffer, string inputPort, string outputPort);
    }

    public class PassThroughBufferVerifier : IPassThroughBufferVerifier
    {
        private readonly IModuleRepository _moduleRepository;

        public PassThroughBufferVerifier(IModuleRepository moduleRepository)
        {
            _moduleRepository = moduleRepository;
        }

        public bool IsPassThroughBuffer(Instance buffer, string inputPort, string outputPort)
        {
            var module = _moduleRepository.Get(buffer.Netlist, buffer.HostModuleName);

            return module.HasPort(buffer.GetWire(inputPort))
                   && module.HasPort(buffer.GetWire(outputPort));
        }
    }
}