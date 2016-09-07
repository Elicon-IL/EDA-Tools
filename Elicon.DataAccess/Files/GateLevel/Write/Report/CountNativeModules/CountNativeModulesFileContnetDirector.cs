using System.Linq;
using Elicon.Domain.GateLevel.Reports.CountNativeModules;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.CountNativeModules
{
    public class CountNativeModulesFileContentDirector : FileContentDirector<CountNativeModulesFileWriteRequest>
    {
        protected override string Construct(CountNativeModulesFileWriteRequest typedRequest)
        {
            var builder = new CountNativeModulesFileContentBuilder();

            builder.BuildTitle();
            builder.BuildNewLine();
            
            var orderedModules = typedRequest.Data.OrderBy(el => el.ModuleName);
            foreach (var module in orderedModules)
                builder.BuildModuleCount(module.ModuleName, module.Count);

            return builder.GetResult();
        }
    }
}