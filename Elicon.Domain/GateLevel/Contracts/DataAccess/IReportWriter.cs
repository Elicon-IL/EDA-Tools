using Elicon.Domain.GateLevel.Reports;
using Elicon.Domain.GateLevel.Reports.CountNativeModules;

namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface IReportWriter
    {
        void Write(IReportWriteRequest reportWriteRequest);
    }
}