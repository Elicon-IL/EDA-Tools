using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public class ModuleReplaceRequest
    {
        public string Netlist { get; set; }
        public string CurrentModule { get; set; }
        public string NewNetlist { get; set; }
        public string NewModule { get; set; }
        public IDictionary<string, string> PortsMap { get; set; }
    }
}