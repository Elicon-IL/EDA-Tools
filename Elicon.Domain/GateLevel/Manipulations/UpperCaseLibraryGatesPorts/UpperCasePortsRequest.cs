namespace Elicon.Domain.GateLevel.Manipulations.UpperCaseLibraryGatesPorts
{
    public class UpperCasePortsRequest : IManipultaionRequest
    {
        public string SourceNetlist { get; set; }
        public string TargetNetlist { get; set; }
    }
}