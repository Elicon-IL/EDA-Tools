using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Library
{
    public class LibraryGate
    {
        public string Name { get; set; }
        public Dictionary<string, LibraryGatePortType> Ports { get; set; }
        public int Nd2Size { get; set; }
        public LibraryGateType Type { get; private set; }

        public LibraryGate(string name, LibraryGateType type, Dictionary<string, LibraryGatePortType> ports, int nd2Size)
        {
            Name = name;
            Type = type;
            Ports = ports;
            Nd2Size = nd2Size;
        }

    }
}