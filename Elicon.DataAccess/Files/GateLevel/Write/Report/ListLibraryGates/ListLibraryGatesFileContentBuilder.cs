using System.Collections.Generic;
using System.Text;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.ListLibraryGates
{
    public class ListLibraryGatesLibraryGatesFileContentBuilder : IListLibraryGatesFileContentBuilder
    {
        private readonly StringBuilder _result = new StringBuilder();

        public void ListModulePorts(string moduleName, IList<string> ports)
        {
            _result.AppendLine("Module = {0}, Ports = ( {1} )".FormatWith(moduleName, ", ".Join(ports)));
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

    public interface IListLibraryGatesFileContentBuilder
    {
        void ListModulePorts(string moduleName, IList<string> ports);
        void BuildNewLine();
        string GetResult();
    }
}