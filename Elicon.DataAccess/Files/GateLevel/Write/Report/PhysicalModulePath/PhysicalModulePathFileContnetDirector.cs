using System.Collections.Generic;
using Elicon.Domain.GateLevel.Reports.PhysicalModulePath;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.PhysicalModulePath
{
    public class PhysicalModulePathFileContentDirector : IPhysicalModulePathFileContentDirector
    {
        public string Construct(IList<string> modulesToList, IList<ModulePhysiclaPaths> data)
        {
            var builder = new PhysicalModulePathFileContentBuilder();

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