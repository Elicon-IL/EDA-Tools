using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.VendorLibraryGates
{
    public class LibraryGate
    {
        public string Name { get; private set; }
        public IList<LibraryGatePort> Ports { get; set; }
        public int Nd2Size { get; private set; }
        public LibraryGateType Type { get; private set; }

        public LibraryGate(string name, LibraryGateType type, IList<LibraryGatePort> ports, int nd2Size)
        {
            Name = name;
            Type = type;
            Ports = ports;
            Nd2Size = nd2Size;
        }
    }
}