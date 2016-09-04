using System.IO;

namespace Elicon.DataAccess.Files.Common.Write
{
    public interface IStreamWriterProvider
    {
        IStreamWriter Get(string source);
    }

    public class StreamWriterProvider : IStreamWriterProvider
    {
        public IStreamWriter Get(string source)
        {
            return new StreamWriterAdapter(source);
        }

        private class StreamWriterAdapter : IStreamWriter
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
}