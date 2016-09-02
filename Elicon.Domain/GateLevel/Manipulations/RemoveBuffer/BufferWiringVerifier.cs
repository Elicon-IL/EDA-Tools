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
        BufferWiring Verify(Instance buffer, string inputPort, string outputPort);
        bool IsPassThroughBuffer(Instance buffer, string inputPort, string outputPort);
        bool BufferIsDrivenByHostModule(Instance buffer, string inputPort);
    }

    public class BufferWiringVerifier : IBufferWiringVerifier
    {
        private readonly IModuleRepository _moduleRepository;

        public BufferWiringVerifier(IModuleRepository moduleRepository)
        {
            _moduleRepository = moduleRepository;
        }

        public BufferWiring Verify(Instance buffer, string inputPort, string outputPort)
        {
            var module = _moduleRepository.Get(buffer.Netlist, buffer.HostModuleName);

            if (module.HasPort(buffer.GetWire(inputPort)) && module.HasPort(buffer.GetWire(outputPort)))
                return BufferWiring.PassThroughBuffer;
            if (module.HasPort(buffer.GetWire(inputPort)))
                return BufferWiring.DrivenByHostModule;
            if (module.HasPort(buffer.GetWire(outputPort)))
                return BufferWiring.DrivesHostModule;

            return BufferWiring.NotConnectedToHostModule;
        }

        public bool IsPassThroughBuffer(Instance buffer, string inputPort, string outputPort)
        {
            var module = _moduleRepository.Get(buffer.Netlist, buffer.HostModuleName);
            return module.HasPort(buffer.GetWire(inputPort)) && module.HasPort(buffer.GetWire(outputPort));
        }

        public bool BufferIsDrivenByHostModule(Instance buffer, string inputPort)
        {
            var module = _moduleRepository.Get(buffer.Netlist, buffer.HostModuleName);
            return module.HasPort(buffer.GetWire(inputPort));
        }
    }
}