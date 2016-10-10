using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;

namespace Elicon.Domain.GateLevel.Manipulations.ReplaceLibraryGate
{
    public class LibraryGateReplaceRequest : IManipultaionRequest
    {
        public string SourceNetlist { get; set; }
        public string GateToReplace { get; set; }
        public string TargetNetlist { get; set; }
        public string NewGate { get; set; }
        public PortsMapping PortsMapping { get; set; }
    }
}