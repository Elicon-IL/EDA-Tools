using System.Collections.Generic;
using System.Text;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.PhysicalModulePath
{
    public class PhysicalModulePathReportBuilder : IPhysicalModulePathReportBuilder
    {
        private readonly StringBuilder _result = new StringBuilder();

        public void BuildTitle(IList<string> modulesToList)
        {
            _result.AppendLine("// Modules to list: {0}".FormatWith(",".Join(modulesToList)));
        }

        public void BuildModuleTitle(string moduleName)
        {
            _result.AppendLine("//");
            _result.AppendLine("// {0} instances:".FormatWith(moduleName));
            _result.AppendLine("//");
        }

        public void BuildPath(string path)
        {
            _result.AppendLine(path);
        }

        public void BuildPathsTotalCount(string moduleName, long count)
        {
            _result.AppendLine("// {0} has {1} instances".FormatWith(moduleName, count));
        }

        public void BuildNewLine()
        {
            _result.AppendLine();
        }

        public string GetResult()
        {
            return _result.ToString();
        }   
    }

    public interface IPhysicalModulePathReportBuilder
    {
        void BuildTitle(IList<string> modulesToList);
        void BuildModuleTitle(string moduleName);
        void BuildPath(string path);
        void BuildPathsTotalCount(string moduleName, long count);
        void BuildNewLine();
        string GetResult();
    }
}