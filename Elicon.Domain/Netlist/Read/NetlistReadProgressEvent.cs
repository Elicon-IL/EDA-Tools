namespace Elicon.Domain.Netlist.Read
{
    public class NetlistReadProgressEvent : IEvent
    {
        public string FileName { get; set; }
        public short Progress { get; set; }
    }
}