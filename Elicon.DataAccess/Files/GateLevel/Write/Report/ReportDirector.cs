using Elicon.Domain.GateLevel.Reports;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report
{
    public interface IReportDirector
    {
        bool CanConstruct(IReportWriteRequest request);
        string Construct(IReportWriteRequest request);
    }

    public abstract class ReportDirector<T> : IReportDirector where T : IReportWriteRequest
    {
        public bool CanConstruct(IReportWriteRequest request)
        {
            return request is T;
        }

        public string Construct(IReportWriteRequest request)
        {
            var typedRequest = (T)request;

            return Construct(typedRequest);
        }

        protected abstract string Construct(T typedRequest);
    }
}