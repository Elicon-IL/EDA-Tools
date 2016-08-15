using System.Collections.Generic;

namespace Elicon.Domain.Netlist.Read
{
    public interface INetlistReadProgressUpdater
    {
        void Update(string source, long length, long position);
        void Done(string source);
    }

    public class NetlistReadProgressUpdater : INetlistReadProgressUpdater
    {
        private readonly Dictionary<string, short> _filesProgression = new Dictionary<string, short>();
        private readonly IPrecentageCalculator _precentageCalculator;
        private readonly IPubSub _pubSub;

        public NetlistReadProgressUpdater(IPubSub pubSub, IPrecentageCalculator precentageCalculator)
        {
            _pubSub = pubSub;
            _precentageCalculator = precentageCalculator;
        }

        public void Update(string source, long length, long position)
        {
            if (!_filesProgression.ContainsKey(source))
                _filesProgression.Add(source, 0);

            var prevValue = _filesProgression[source];
            var newValue = _precentageCalculator.ClaculatePrecentage(position, length);

            if (NoChange(newValue, prevValue))
                return;

            _filesProgression[source] = newValue;
            _pubSub.Publish(new NetlistReadProgressEvent {
                FileName = source,
                Progress = newValue
            });
        }

        public void Done(string source)
        {
            _pubSub.Publish(new NetlistReadProgressEvent {
                FileName = source,
                Progress = 100
            });

            _filesProgression.Remove(source);
        }

        private bool NoChange(short newValue, short prevValue)
        {
            return newValue <= prevValue;
        }
    }
}