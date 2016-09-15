using System.Collections.Generic;
using Elicon.Domain.GateLevel.Reports.NativeModulesPortsList;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.NativeModulesPortsList
{
    public class NativeModulesPortListFileContentDirector : INativeModulesPortListFileContentDirector
    {
        public string Construct(IList<NativeModulePorts> data)
        {
            var builder = new NativeModulesPortListFileContentBuilder();

            foreach (var module in data)
                builder.ListModulePorts(module.ModuleName, module.Ports);

            return builder.GetResult();
        }
    }
}