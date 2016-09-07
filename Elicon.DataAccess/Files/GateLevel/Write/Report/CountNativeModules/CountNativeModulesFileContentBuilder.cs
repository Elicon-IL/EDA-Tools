using System.Text;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.CountNativeModules
{
    public class CountNativeModulesFileContentBuilder : ICountNativeModulesFileContentBuilder
    {
        private readonly StringBuilder _result = new StringBuilder();

        public void BuildModuleCount(string moduleName, long moduleCount)
        {
            _result.AppendLine("Module = {0}, Count = {1}".FormatWith(moduleName, moduleCount));
        }

        public void BuildTitle()
        {
            _result.AppendLine("==========================");
            _result.AppendLine("Module         Count");
            _result.AppendLine("==========================");
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

    public interface ICountNativeModulesFileContentBuilder
    {
        void BuildTitle();
        void BuildModuleCount(string moduleName, long moduleCount);
        void BuildNewLine();
        string GetResult();
    }
}