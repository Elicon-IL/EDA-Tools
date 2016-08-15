using System.IO;

namespace Elicon.Framework
{
    public interface IStreamReader
    {
        void SetSource(string source);
        void Close();
        string ReadLine();
        string Source();
        long Length();
        long Position();
    }

    public class AdapterStreamReader : IStreamReader
    {
        private StreamReader _reader;
        private string _source;

        public void SetSource(string source)
        {
            _source = source;
            _reader?.Close();
            _reader = new StreamReader(source);
        }

        public string ReadLine()
        {
            return _reader.ReadLine();
        }

        public string Source()
        {
            return _source;
        }

        public long Length()
        {
            return _reader.BaseStream.Length;
        }

        public long Position()
        {
            return _reader.BaseStream.Position;
        }

        public void Close()
        {
            _reader.Close();
        }
    }
}