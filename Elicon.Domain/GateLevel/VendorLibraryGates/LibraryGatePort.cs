namespace Elicon.Domain.GateLevel.VendorLibraryGates
{
    public class LibraryGatePort
    {
        public string Name { get; set; }
        public LibraryGatePortType Type { get; set; }

        public LibraryGatePort() {}

        public LibraryGatePort(LibraryGatePort gatePort)
        {
            Name = gatePort.Name;
            Type = gatePort.Type;
        }
    }
}