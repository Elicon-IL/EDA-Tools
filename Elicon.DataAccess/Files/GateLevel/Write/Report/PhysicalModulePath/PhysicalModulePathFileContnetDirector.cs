using Elicon.Domain.GateLevel.Reports.PhysicalModulePath;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.PhysicalModulePath
{
    public class PhysicalModulePathFileContentDirector : FileContentDirector<PhysicalModulePathFileWriteRequest>
    {
        protected override string Construct(PhysicalModulePathFileWriteRequest typedRequest)
        {
            var builder = new PhysicalModulePathFileContentBuilder();

            builder.BuildTitle(typedRequest.ModulesToList);
            builder.BuildNewLine();

            foreach (var module in typedRequest.Data)
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