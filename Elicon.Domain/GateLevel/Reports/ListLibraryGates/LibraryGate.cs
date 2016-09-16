using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Reports.ListLibraryGates
{
    public class LibraryGate
    {
        public LibraryGate(string moduleName, IList<string> ports)
        {
            ModuleName = moduleName;
            Ports = ports;
        }
        public string ModuleName { get; set; }
        public IList<string> Ports { get; set; }
    }
}