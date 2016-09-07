using System.Linq;
using Elicon.Domain.GateLevel.Reports.CountNativeModules;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.CountNativeModules
{
    public class CountNativeModulesReportDirector : ReportDirector<CountNativeModulesReportWriteRequest>
    {
        protected override string Construct(CountNativeModulesReportWriteRequest typedRequest)
        {
            var builder = new CountNativeModulesReportBuilder();

            builder.BuildTitle();
            builder.BuildNewLine();
            
            var orderedModules = typedRequest.Data.OrderBy(kvp => kvp.Key);
            foreach (var kvp in orderedModules)
                builder.BuildModuleCount(kvp.Key, kvp.Value);

            return builder.GetResult();
        }
    }
}