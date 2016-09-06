using System.Collections.Generic;
using System.Text;
using Elicon.Domain.GateLevel.Reports.PhysicalModulePath;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report
{
    public class PhysicalModulePathReportBuilder : ReportBuilder<PhysicalModulePathReportWriteRequest>
    {
        private readonly IFileTitleBuilder _fileTitleBuilder;

        public PhysicalModulePathReportBuilder(IFileTitleBuilder fileTitleBuilder)
        {
            _fileTitleBuilder = fileTitleBuilder;
        }

        protected override string Build(PhysicalModulePathReportWriteRequest typedRequest)
        {
            var result = new StringBuilder();

            AppendTitle(result);
            AppendModulesToListSubTitle(result, typedRequest.ModulesToList);
            AppendPhysicaPaths(typedRequest.Data, result);
                
            return result.ToString();
        }

        private static void AppendPhysicaPaths(IDictionary<string, IList<string>> data, StringBuilder result)
        {
            foreach (var kvp in data)
            {
                result.AppendLine("// {0} instances:".FormatWith(kvp.Key));
                foreach (var path in kvp.Value)
                    result.AppendLine(path);

                result.AppendLine("// {0} has {1} instances:".FormatWith(kvp.Key, kvp.Value.Count));
            }
        }

        private void AppendTitle(StringBuilder result)
        {
            result.AppendLine(_fileTitleBuilder.BuildTitle("List Physical Module Paths"));
        }

        private void AppendModulesToListSubTitle(StringBuilder result, IList<string> modulesToList)
        {
            result.AppendLine("// Modules to list: {0}".FormatWith(",".Join(modulesToList)));
        }
    }
}