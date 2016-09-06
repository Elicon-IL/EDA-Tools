using System.Collections.Generic;
using System.Linq;
using System.Text;
using Elicon.Domain.GateLevel.Reports.CountNativeModules;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report
{
    public class CountNativeModulesReportBuilder : ReportBuilder<CountNativeModulesReportWriteRequest>
    {
        private readonly IFileTitleBuilder _fileTitleBuilder;

        public CountNativeModulesReportBuilder(IFileTitleBuilder fileTitleBuilder)
        {
            _fileTitleBuilder = fileTitleBuilder;
        }

        protected override string Build(CountNativeModulesReportWriteRequest typedRequest)
        {
            var result = new StringBuilder();

            AppendTitle(result);
            AppendModulesCount(result, typedRequest.Data);

            return result.ToString();
        }

        private void AppendModulesCount(StringBuilder result, IDictionary<string,long> data)
        {
            var orderedModules = data.OrderBy(kvp => kvp.Key);
            foreach (var kvp in orderedModules)
                result.AppendLine("Module = {0}, Count = {1}".FormatWith(kvp.Key, kvp.Value));
        }

        private void AppendTitle(StringBuilder result)
        {
            result.AppendLine(_fileTitleBuilder.BuildTitle("Count Native Modules"));
        }
    }
}