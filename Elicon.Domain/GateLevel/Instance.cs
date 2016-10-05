using System.Collections.Generic;
using System.Linq;

namespace Elicon.Domain.GateLevel
{
    public enum InstanceType
    {
        Unknown = 0,
        LibraryGate,
        Module
    };

    public class Instance
    {
        public Instance(string netlist, string hostModule, string moduleName, string instanceName)
        {
            Netlist = netlist;
            HostModuleName = hostModule;
            ModuleName = moduleName;
            InstanceName = instanceName;
            Net = new List<PortWirePair>();
        }

        public Instance(Instance instance)
        {
            Id = instance.Id;
            Netlist = instance.Netlist;
            HostModuleName = instance.HostModuleName;
            ModuleName = instance.ModuleName;
            InstanceName = instance.InstanceName;
            Type = instance.Type;
            Net = instance.Net.Select(pwp => new PortWirePair(pwp)).ToList();
        }


        public long Id { get; set; }
        public string Netlist { get; set; }
        public string HostModuleName { get; set; }
        public string ModuleName { get; set; }
        public string InstanceName { get; set; }
        public InstanceType Type { get; set; }
        public IList<PortWirePair> Net { get; set; }
    }

    public static class InstanceExtensions
    {
        public static bool IsModule(this Instance target)
        {
            return target.Type == InstanceType.Module;
        }

        public static string GetWire(this Instance target, string port)
        {
            return target.Net.SingleOrDefault(pwp => pwp.Port == port)?.Wire;
        }
    }
}
