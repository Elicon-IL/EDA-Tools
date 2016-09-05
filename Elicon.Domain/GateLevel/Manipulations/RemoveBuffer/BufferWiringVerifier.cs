using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.RemoveBuffer
{
    public enum BufferWiring
    {
        PassThroughBuffer,
        DrivenByHostModule,
        DrivesHostModule,
        NotConnectedToHostModule
    }

    public interface IBufferWiringVerifier
    {
        bool IsPassThroughBuffer(Instance buffer, string inputPort, string outputPort);
        bool HostModuleDrivesBuffer(Instance buffer, string inputPort);
    }

    public class BufferWiringVerifier : IBufferWiringVerifier
    {
        private readonly IModuleRepository _moduleRepository;

        public BufferWiringVerifier(IModuleRepository moduleRepository)
        {
            _moduleRepository = moduleRepository;
        }

        public bool IsPassThroughBuffer(Instance buffer, string inputPort, string outputPort)
        {
            var module = _moduleRepository.Get(buffer.Netlist, buffer.HostModuleName);
            return module.HasPort(buffer.GetWire(inputPort)) && module.HasPort(buffer.GetWire(outputPort));
        }

        public bool HostModuleDrivesBuffer(Instance buffer, string inputPort)
        {
            var module = _moduleRepository.Get(buffer.Netlist, buffer.HostModuleName);
            return module.HasPort(buffer.GetWire(inputPort));
        }
    }
}