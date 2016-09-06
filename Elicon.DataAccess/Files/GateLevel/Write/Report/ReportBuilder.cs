using System.Linq;
using System.Text;
using Elicon.Domain.GateLevel.Reports;
using Elicon.Domain.GateLevel.Reports.CountNativeModules;
using Elicon.Domain.GateLevel.Reports.PhysicalModulePath;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report
{
    public interface IReportBuilder
    {
        bool CanBuild(IReportWriteRequest request);
        string Build(IReportWriteRequest request);
    }

    public abstract class ReportBuilder<T> : IReportBuilder where T : IReportWriteRequest
    {
        public bool CanBuild(IReportWriteRequest request)
        {
            return request is T;
        }

        public string Build(IReportWriteRequest request)
        {
            var typedRequest = (T)request;

            return Build(typedRequest);
        }

        protected abstract string Build(T typedRequest);
    }
    
    public class CountNativeModulesReportBuilder : ReportBuilder<CountNativeModulesReportWriteRequest>
    {
        private readonly IFileTitleBuilder _fileTitleBuilder;

        public CountNativeModulesReportBuilder(IFileTitleBuilder fileTitleBuilder)
        {
            _fileTitleBuilder = fileTitleBuilder;
        }

        protected override string Build(CountNativeModulesReportWriteRequest typedRequest)
        {
            var sb = new StringBuilder();
            sb.AppendLine(_fileTitleBuilder.BuildTitle("Count Native Modules"));

            var orderedModules = typedRequest.Data.OrderBy(kvp => kvp.Key);
            foreach (var kvp in orderedModules)
                sb.AppendLine("Cell = {0}, count = {1}".FormatWith(kvp.Key, kvp.Value));

            return sb.ToString();
        }
    }

    public class PhysicalModulePathReportBuilder : ReportBuilder<PhysicalModulePathReportWriteRequest>
    {
        private readonly IFileTitleBuilder _fileTitleBuilder;

        public PhysicalModulePathReportBuilder(IFileTitleBuilder fileTitleBuilder)
        {
            _fileTitleBuilder = fileTitleBuilder;
        }

        protected override string Build(PhysicalModulePathReportWriteRequest typedRequest)
        {
            var sb = new StringBuilder();

            sb.AppendLine(_fileTitleBuilder.BuildTitle("List Physical Module Paths"));
            sb.AppendLine("// Modules to list: {0}".FormatWith(",".Join(typedRequest.ModulesToList)));

            foreach (var kvp in typedRequest.Data)
            {
                sb.AppendLine("// {0} instances:".FormatWith(kvp.Key));
                foreach (var path in kvp.Value)
                    sb.AppendLine(path);

                sb.AppendLine("// {0} has {1} instances:".FormatWith(kvp.Key, kvp.Value.Count));
            }
                
            return sb.ToString();
        }
    }
}