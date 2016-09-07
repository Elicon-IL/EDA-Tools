using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Reports.PhysicalModulePath
{
    public class PhysicalModulePathFileWriteRequest : IFileWriteRequest
    {
        public string Destination { get; set; }
        public string Action { get; set; } = "List Phyisical Paths";
        public IList<ModulePhysiclaPaths> Data { get; set; }
        public IList<string> ModulesToList { get; set; }
    }
}