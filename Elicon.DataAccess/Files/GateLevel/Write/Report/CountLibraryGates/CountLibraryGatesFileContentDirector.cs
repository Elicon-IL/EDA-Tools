using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel.Reports.CountLibraryGates;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.CountLibraryGates
{
    public class CountLibraryGatesFileContentDirector : ICountLibraryGatesFileContentDirector
    {
        public string Construct(IList<LibraryGateCount> data)
        {
            var builder = new CountLibraryGatesFileContentBuilder();

            builder.BuildTitle();
            builder.BuildNewLine();
            
            var orderedModules = data.OrderBy(el => el.ModuleName);
            foreach (var module in orderedModules)
                builder.BuildModuleCount(module.ModuleName, module.Count);

            return builder.GetResult();
        }
    }
}