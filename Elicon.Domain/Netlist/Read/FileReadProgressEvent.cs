namespace Elicon.Domain.Netlist.Read
{
    public class FileReadProgressEvent : IEvent
    {
        public string FileName { get; set; }
        public short Progress { get; set; }
    }
}