using System.IO;

namespace Elicon.DataAccess.Files.Common.Write
{
    public interface IStreamWriter
    {
        void WriteLine(string line);
        void WriteLine();
        void Close();
    }

    public class StreamWriterAdapter : IStreamWriter
    {
        private readonly StreamWriter _streamWriter;
       
        public StreamWriterAdapter(string source)
        {
            _streamWriter = new StreamWriter(source);
        }

        public void WriteLine(string line)
        {
           _streamWriter.WriteLine(line);
        }

        public void WriteLine()
        {
            _streamWriter.WriteLine();
        }

        public void Close()
        {
            _streamWriter.Close();
        }
    }
}