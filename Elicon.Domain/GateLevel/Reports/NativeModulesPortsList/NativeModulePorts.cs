using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Reports.NativeModulesPortsList
{
    public class NativeModulePorts
    {
        public NativeModulePorts(string moduleName, IList<string> ports)
        {
            ModuleName = moduleName;
            Ports = ports;
        }
        public string ModuleName { get; set; }
        public IList<string> Ports { get; set; }
    }
}