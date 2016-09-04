using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule
{
    public class ModuleReplaceRequest
    {
        public string Netlist { get; set; }
        public string ModuleToReplace { get; set; }
        public string NewNetlist { get; set; }
        public string NewModule { get; set; }
        public PortsMapping PortsMapping { get; set; }
    }
}