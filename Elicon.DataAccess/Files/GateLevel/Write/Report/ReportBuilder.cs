using Elicon.Domain.GateLevel.Reports;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report
{
    public interface IReportBuilder
    {
        bool CanBuild(IReportWriteRequest request);
        string Build(IReportWriteRequest request);
    }

    public abstract class ReportBuilder<T> : IReportBuilder where T : IReportWriteRequest
    {
        public bool CanBuild(IReportWriteRequest request)
        {
            return request is T;
        }

        public string Build(IReportWriteRequest request)
        {
            var typedRequest = (T)request;

            return Build(typedRequest);
        }

        protected abstract string Build(T typedRequest);
    }
}