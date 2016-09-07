using Elicon.Domain.GateLevel.Reports.NativeModulesPortsList;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.NativeModulesPortsList
{
    public class NativeModulesPortsListFileContentDirector : FileContentDirector<NativeModulesPortListFileWriteRequest>
    {
        protected override string Construct(NativeModulesPortListFileWriteRequest typedRequest)
        {
            var builder = new NativeModulesPortsListFileContentBuilder();

            foreach (var module in typedRequest.Data)
                builder.ListModulePorts(module.ModuleName, module.Ports);

            return builder.GetResult();
        }
    }
}