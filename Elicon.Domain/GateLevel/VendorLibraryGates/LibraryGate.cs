using System.Collections.Generic;
using System.Linq;

namespace Elicon.Domain.GateLevel.VendorLibraryGates
{
    public class LibraryGate
    {
        public string Name { get;  set; }
        public IList<LibraryGatePort> Ports { get; set; }
        public int Nd2Size { get;  set; }
        public LibraryGateType Type { get;  set; }

        public LibraryGate(){}

        public LibraryGate(string name, LibraryGateType type, IList<LibraryGatePort> ports, int nd2Size)
        {
            Name = name;
            Type = type;
            Ports = ports;
            Nd2Size = nd2Size;
        }

        public LibraryGate(LibraryGate libraryGate)
        {
            Name = libraryGate.Name;
            Type = libraryGate.Type;
            Ports = libraryGate.Ports.Select(port => new LibraryGatePort(port)).ToList();
            Nd2Size = libraryGate.Nd2Size;
        }
    }
}