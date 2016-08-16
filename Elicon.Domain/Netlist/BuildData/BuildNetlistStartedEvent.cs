namespace Elicon.Domain.Netlist.BuildData
{
    public class BuildNetlistStartedEvent : IEvent
    {
        public string Source { get; set; }
    }
}