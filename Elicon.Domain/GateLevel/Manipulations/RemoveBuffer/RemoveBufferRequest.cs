namespace Elicon.Domain.GateLevel.Manipulations.RemoveBuffer
{
    public class RemoveBufferRequest
    {
        public string Netlist { get; set; }
        public string NewNetlist { get; set; }
        public string BufferName { get; set; }
        public string InputPort { get; set; }
        public string OutputPort { get; set; }
    }
}