using System.Linq;
using Elicon.DataAccess.Files.Common.Write;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Reports;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report
{
    public class ReportWriter : IReportWriter
    {
        private readonly IStreamWriterProvider _streamWriterProvider;
        private readonly IFileHeaderBuilder _fileHeaderBuilder;
        private readonly IReportDirector[] _reportDirectors;

        public ReportWriter(IStreamWriterProvider streamWriterProvider, IReportDirector[] reportDirectors, IFileHeaderBuilder fileHeaderBuilder)
        {
            _streamWriterProvider = streamWriterProvider;
            _reportDirectors = reportDirectors;
            _fileHeaderBuilder = fileHeaderBuilder;
        }

        public void Write(IReportWriteRequest reportWriteRequest)
        {
            var writer = _streamWriterProvider.Get(reportWriteRequest.Destination);
            var reportDirector = _reportDirectors.Single(r => r.CanConstruct(reportWriteRequest));

            var header = _fileHeaderBuilder.BuildHeader(reportWriteRequest.Action);
            var content = reportDirector.Construct(reportWriteRequest);

            writer.WriteLine(header);
            writer.WriteLine(content);

            writer.Close();
        }
    }
}