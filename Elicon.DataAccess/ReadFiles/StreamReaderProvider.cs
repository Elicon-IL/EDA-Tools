using Elicon.Domain;
using Elicon.Framework;

namespace Elicon.DataAccess.ReadFiles
{
    public interface IStreamReaderProvider
    {
        IStreamReader Get(string source);
    }

    public class StreamReaderProvider : IStreamReaderProvider
    {
        private readonly IPubSub _pubSub;
        private readonly IPrecentageCalculator _precentageCalculator;

        public StreamReaderProvider(IPubSub pubSub, IPrecentageCalculator precentageCalculator)
        {
            _pubSub = pubSub;
            _precentageCalculator = precentageCalculator;
        }

        public IStreamReader Get(string source)
        {
            return new StreamReaderAdapter(source, _pubSub, _precentageCalculator);
        }
    }
}