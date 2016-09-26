using System.Text;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.CountLibraryGates
{
    public class CountLibraryGatesFileContentBuilder : ICountLibraryGatesFileContentBuilder
    {
        private readonly StringBuilder _result = new StringBuilder();

        public void BuildModuleCount(string moduleName, long moduleCount)
        {
            _result.AppendLine("{0}{1}".FormatWith(moduleName.PadRight(26), moduleCount));
        }

        public void BuildTitle()
        {
            _result.AppendLine("==============================");
            _result.AppendLine("Gate                   Count");
            _result.AppendLine("==============================");
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

    public interface ICountLibraryGatesFileContentBuilder
    {
        void BuildTitle();
        void BuildModuleCount(string moduleName, long moduleCount);
        void BuildNewLine();
        string GetResult();
    }
}