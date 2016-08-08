using System.IO;

namespace Elicon.Domain.Netlist.Read
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