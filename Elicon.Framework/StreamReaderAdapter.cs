using System.IO;

namespace Elicon.Framework
{
    public interface IStreamReader
    {
        void SetSource(string source);
        void Close();
        string ReadLine();
    }

    public class StreamReaderAdapter : IStreamReader
    {
        private StreamReader _reader;

        public void SetSource(string source)
        {
            _reader?.Close();

            _reader = new StreamReader(source);
        }

        public string ReadLine()
        {
            return _reader.ReadLine();
        }

        public void Close()
        {
            _reader.Close();
        }
    }
}