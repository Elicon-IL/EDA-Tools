using System.Collections.Generic;
using Elicon.Domain.GateLevel.Reports.ListLibraryGates;

namespace Elicon.DataAccess.Files.GateLevel.Write.Report.ListLibraryGates
{
    public class ListLibraryGatesFileContentDirector : IListLibraryGatesFileContentDirector
    {
        public string Construct(IList<LibraryGate> data)
        {
            var builder = new ListLibraryGatesLibraryGatesFileContentBuilder();

            foreach (var module in data)
                builder.ListModulePorts(module.ModuleName, module.Ports);

            return builder.GetResult();
        }
    }
}