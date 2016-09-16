using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Reports.ListPhysicalPaths
{
    public class ModulePhysiclaPaths
    {
        public ModulePhysiclaPaths(string moduleName, IList<string> paths)
        {
            ModuleName = moduleName;
            Paths = paths;
        }

        public string ModuleName { get; set; }
        public IList<string> Paths { get; set; }
    }
}