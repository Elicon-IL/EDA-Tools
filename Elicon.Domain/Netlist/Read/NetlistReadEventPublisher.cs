namespace Elicon.Domain.Netlist.Read
{
    public interface INetlistReadEventPublisher
    {
        void PublishFileOpen(string source);
        void PublishFileClosed(string source);
        void PublishProgress(string source, long length, long position);
    }

    public class NetlistReadEventPublisher : INetlistReadEventPublisher
    {
        private readonly IPubSub _pubSub;

        public NetlistReadEventPublisher(IPubSub pubSub)
        {
            _pubSub = pubSub;
        }

        public void PublishFileOpen(string source)
        {
            _pubSub.Publish(new NetlistFileOpenedEvent { FileName = source });
        }

        public void PublishFileClosed(string source)
        {
            _pubSub.Publish(new NetlistFileClosedEvent { FileName = source });
        }

        public void PublishProgress(string source, long length, long position)
        {
            _pubSub.Publish(new NetlistFileReadLineEvent
            {
                FileName = source,
                FileLength = length,
                FilePosition = position
            });
        }
    }

    public class NetlistFileReadLineEvent : IEvent
    {
        public string FileName { get; set; }
        public long FileLength { get; set; }
        public long FilePosition { get; set; }
    }

    public class NetlistFileClosedEvent : IEvent
    {
        public string FileName { get; set; }
    }

    public class NetlistFileOpenedEvent : IEvent
    {
        public string FileName { get; set; }
    }
}