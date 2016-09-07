namespace Elicon.Domain.GateLevel.Manipulations
{
    public class NetlistFileWriteRequest : IFileWriteRequest
    {
        public string Destination { get; set; }
        public string Action { get; set; }
    }
}