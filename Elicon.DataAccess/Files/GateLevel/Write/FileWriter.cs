using System.Linq;
using Elicon.DataAccess.Files.Common.Write;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Reports;

namespace Elicon.DataAccess.Files.GateLevel.Write
{
    public class FileWriter : IFileWriter
    {
        private readonly IStreamWriterProvider _streamWriterProvider;
        private readonly IFileHeaderBuilder _fileHeaderBuilder;
        private readonly IFileContnetDirector[] _fileContnetDirectors;

        public FileWriter(IStreamWriterProvider streamWriterProvider, IFileContnetDirector[] fileContnetDirectors, IFileHeaderBuilder fileHeaderBuilder)
        {
            _streamWriterProvider = streamWriterProvider;
            _fileContnetDirectors = fileContnetDirectors;
            _fileHeaderBuilder = fileHeaderBuilder;
        }

        public void Write(IFileWriteRequest fileWriteRequest)
        {
            var writer = _streamWriterProvider.Get(fileWriteRequest.Destination);
            var reportDirector = _fileContnetDirectors.Single(r => r.CanConstruct(fileWriteRequest));

            var header = _fileHeaderBuilder.BuildHeader(fileWriteRequest.Action);
            var content = reportDirector.Construct(fileWriteRequest);

            writer.WriteLine(header);
            writer.WriteLine(content);

            writer.Close();
        }
    }
}