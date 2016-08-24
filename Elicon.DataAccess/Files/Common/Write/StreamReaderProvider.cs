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
    }
}