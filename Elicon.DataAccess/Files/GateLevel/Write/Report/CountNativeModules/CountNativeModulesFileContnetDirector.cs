using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel.Reports.CountNativeModules;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.CountNativeModules
{
    public class CountNativeModulesFileContentDirector : ICountNativeModulesFileContentDirector
    {
        public string Construct(IList<NativeModuleCount> data)
        {
            var builder = new CountNativeModulesFileContentBuilder();

            builder.BuildTitle();
            builder.BuildNewLine();
            
            var orderedModules = data.OrderBy(el => el.ModuleName);
            foreach (var module in orderedModules)
                builder.BuildModuleCount(module.ModuleName, module.Count);

            return builder.GetResult();
        }
    }
}