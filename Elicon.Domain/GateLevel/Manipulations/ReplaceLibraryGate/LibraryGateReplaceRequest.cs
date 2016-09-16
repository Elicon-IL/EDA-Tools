namespace Elicon.Domain.GateLevel.Manipulations.ReplaceLibraryGate
{
    public class LibraryGateReplaceRequest
    {
        public string Netlist { get; set; }
        public string GateToReplace { get; set; }
        public string NewNetlist { get; set; }
        public string NewGate { get; set; }
        public PortsMapping PortsMapping { get; set; }
    }
}