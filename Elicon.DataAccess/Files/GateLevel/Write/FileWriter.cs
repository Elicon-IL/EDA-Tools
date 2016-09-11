using System.Linq;
using Elicon.DataAccess.Files.Common.Write;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess.Files.GateLevel.Write
{
    public class FileWriter : IFileWriter
    {
        private readonly IStreamWriterProvider _streamWriterProvider;
        private readonly IFileHeaderBuilder _fileHeaderBuilder;

        public FileWriter(IStreamWriterProvider streamWriterProvider, IFileHeaderBuilder fileHeaderBuilder)
        {
            _streamWriterProvider = streamWriterProvider;
            _fileHeaderBuilder = fileHeaderBuilder;
        }

        public void Write(string dest, string action, string content)
        {
            var writer = _streamWriterProvider.Get(dest);

            var header = _fileHeaderBuilder.BuildHeader(action);

            writer.WriteLine(header);
            writer.WriteLine(content);

            writer.Close();
        }
    }
}