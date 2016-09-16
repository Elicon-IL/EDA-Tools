using System.Collections.Generic;
using Elicon.Domain.GateLevel.Reports.ListPhysicalPaths;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.PhysicalModulePath
{
    public class ListPhysicalPathsFileContentDirector : IListPhysicalPathsFileContentDirector
    {
        public string Construct(IList<string> modulesToList, IList<ModulePhysiclaPaths> data)
        {
            var builder = new ListPhysicalPathsFileContentBuilder();

            builder.BuildTitle(modulesToList);
            builder.BuildNewLine();

            foreach (var module in data)
            {
                builder.BuildModuleTitle(module.ModuleName);
                foreach (var path in module.Paths)
                    builder.BuildPath(path);

                builder.BuildPathsTotalCount(module.ModuleName, module.Paths.Count);
                builder.BuildNewLine();
            }

            return builder.GetResult();
        }
    }
}