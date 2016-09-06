using System.Linq;
using Elicon.DataAccess.Files.Common.Write;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Reports;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report
{
    public class ReportWriter : IReportWriter
    {
        private readonly IStreamWriterProvider _streamWriterProvider;
        private readonly IReportBuilder[] _reportBuilders;

        public ReportWriter(IStreamWriterProvider streamWriterProvider, IReportBuilder[] reportBuilders)
        {
            _streamWriterProvider = streamWriterProvider;
            _reportBuilders = reportBuilders;
        }

        public void Write(IReportWriteRequest reportWriteRequest)
        {
            var writer = _streamWriterProvider.Get(reportWriteRequest.Destination);

            writer.WriteLine(_reportBuilders.Single(r => 
                r.CanBuild(reportWriteRequest)).Build(reportWriteRequest));

            writer.Close();
        }
    }
}