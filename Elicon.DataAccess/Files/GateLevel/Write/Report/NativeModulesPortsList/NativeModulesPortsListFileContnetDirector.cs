using System.Linq;
using Elicon.DataAccess.Files.GateLevel.Write.Report.CountNativeModules;
using Elicon.Domain.GateLevel.Reports.NativeModulesPortsList;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.NativeModulesPortsList
{
    public class NativeModulesPortsListFileContnetDirector : FileContnetDirector<NativeModulesPortListFileWriteRequest>
    {
        protected override string Construct(NativeModulesPortListFileWriteRequest typedRequest)
        {
            var builder = new NativeModulesPortsListFileContentBuilder();

            foreach (var kvp in typedRequest.Data)
                builder.ListModulePorts(kvp.Key, kvp.Value);

            return builder.GetResult();
        }
    }
}