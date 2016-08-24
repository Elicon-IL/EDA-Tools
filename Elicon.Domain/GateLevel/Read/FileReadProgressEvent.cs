namespace Elicon.Domain.GateLevel.Read
{
    public class FileReadProgressEvent : IEvent
    {
        public string FileName { get; set; }
        public short Progress { get; set; }
    }
}