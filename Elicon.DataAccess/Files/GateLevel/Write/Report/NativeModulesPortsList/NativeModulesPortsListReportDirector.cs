using System.Linq;
using Elicon.DataAccess.Files.GateLevel.Write.Report.CountNativeModules;
using Elicon.Domain.GateLevel.Reports.NativeModulesPortsList;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.NativeModulesPortsList
{
    public class NativeModulesPortsListReportDirector : ReportDirector<NativeModulesPortListReportWriteRequest>
    {
        protected override string Construct(NativeModulesPortListReportWriteRequest typedRequest)
        {
            var builder = new NativeModulesPortsListReportBuilder();

            foreach (var kvp in typedRequest.Data)
                builder.ListModulePorts(kvp.Key, kvp.Value);

            return builder.GetResult();
        }
    }
}