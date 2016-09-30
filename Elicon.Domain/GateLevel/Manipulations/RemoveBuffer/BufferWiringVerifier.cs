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
        bool IsPassThroughBuffer(Module hostModule, Instance buffer, string inputPort, string outputPort);
        bool HostModuleDrivesBuffer(Module hostModule, Instance buffer, string inputPort);
    }

    public class BufferWiringVerifier : IBufferWiringVerifier
    {
        public bool IsPassThroughBuffer(Module hostModule, Instance buffer, string inputPort, string outputPort)
        {
            return hostModule.HasPort(buffer.GetWire(inputPort)) && hostModule.HasPort(buffer.GetWire(outputPort));
        }

        public bool HostModuleDrivesBuffer(Module hostModule, Instance buffer, string inputPort)
        {
            return hostModule.HasPort(buffer.GetWire(inputPort));
        }
    }
}