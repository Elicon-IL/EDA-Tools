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
        private readonly IFileContentDirector[] _fileContentDirectors;

        public FileWriter(IStreamWriterProvider streamWriterProvider, IFileContentDirector[] fileContentDirectors, IFileHeaderBuilder fileHeaderBuilder)
        {
            _streamWriterProvider = streamWriterProvider;
            _fileContentDirectors = fileContentDirectors;
            _fileHeaderBuilder = fileHeaderBuilder;
        }

        public void Write(IFileWriteRequest fileWriteRequest)
        {
            var writer = _streamWriterProvider.Get(fileWriteRequest.Destination);
            var reportDirector = _fileContentDirectors.Single(r => r.CanConstruct(fileWriteRequest));

            var header = _fileHeaderBuilder.BuildHeader(fileWriteRequest.Action);
            var content = reportDirector.Construct(fileWriteRequest);

            writer.WriteLine(header);
            writer.WriteLine(content);

            writer.Close();
        }
    }
}