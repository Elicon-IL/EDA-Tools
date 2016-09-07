using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Reports.PhysicalModulePath
{
    public class PhysicalModulePathReportWriteRequest : IReportWriteRequest
    {
        public string Destination { get; set; }
        public string Action { get; } = "List Phyisical Paths";
        public IDictionary<string, IList<string>> Data { get; set; }
        public IList<string> ModulesToList { get; set; }
    }
}