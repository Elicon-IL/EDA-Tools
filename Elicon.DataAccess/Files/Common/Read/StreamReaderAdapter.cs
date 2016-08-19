using System.IO;
using Elicon.Domain;
using Elicon.Domain.Netlist.Read;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.Common.Read
{
    public interface IStreamReader
    {
        string ReadLine();
    }

    public class StreamReaderAdapter : IStreamReader
    {
        private readonly StreamReader _reader;
        private readonly string _source;
        private short _prevProgress;
        private readonly IPubSub _pubSub;
        private readonly IPrecentageCalculator _precentageCalculator;

        public StreamReaderAdapter(string source, IPubSub pubSub, IPrecentageCalculator precentageCalculator)
        {
            _reader = new StreamReader(source);
            _source = source;
            _pubSub = pubSub;
            _precentageCalculator = precentageCalculator;
        }

        public string ReadLine()
        {
            var currentLine = _reader.ReadLine();
            PublishProgress();

            if (currentLine == null)
                _reader.Close();

            return currentLine;
        }

        private void PublishProgress()
        {
            var newProgress = _precentageCalculator.CalculatePrecentage(_reader.BaseStream.Position, _reader.BaseStream.Length);
            if (NoChange(newProgress, _prevProgress))
                return;

            _pubSub.Publish(new FileReadProgressEvent {
                FileName = _source,
                Progress = newProgress
            });

            _prevProgress = newProgress;
        }

        private bool NoChange(short newValue, short prevValue)
        {
            return newValue == prevValue;
        }
    }
}