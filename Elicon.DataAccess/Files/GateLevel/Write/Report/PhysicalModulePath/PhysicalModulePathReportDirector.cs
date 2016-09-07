using Elicon.Domain.GateLevel.Reports.PhysicalModulePath;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.PhysicalModulePath
{
    public class PhysicalModulePathReportDirector : ReportDirector<PhysicalModulePathReportWriteRequest>
    {
        protected override string Construct(PhysicalModulePathReportWriteRequest typedRequest)
        {
            var builder = new PhysicalModulePathReportBuilder();

            builder.BuildTitle(typedRequest.ModulesToList);
            builder.BuildNewLine();

            foreach (var kvp in typedRequest.Data)
            {
                builder.BuildModuleTitle(kvp.Key);
                foreach (var path in kvp.Value)
                    builder.BuildPath(path);

                builder.BuildPathsTotalCount(kvp.Key,kvp.Value.Count);
                builder.BuildNewLine();
            }

            return builder.GetResult();
        }
    }
}