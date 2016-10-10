namespace Elicon.Domain.GateLevel.Manipulations.RemoveBuffer
{
    public class RemoveBufferRequest : IManipultaionRequest
    {
        public string SourceNetlist { get; set; }
        public string TargetNetlist { get; set; }
        public string BufferName { get; set; }
        public string InputPort { get; set; }
        public string OutputPort { get; set; }
    }
}