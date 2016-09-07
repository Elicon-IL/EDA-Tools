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
            
            var orderedModules = typedRequest.Data.OrderBy(kvp => kvp.Key);
            foreach (var kvp in orderedModules)
                builder.BuildModuleCount(kvp.Key, kvp.Value);

            return builder.GetResult();
        }
    }
}