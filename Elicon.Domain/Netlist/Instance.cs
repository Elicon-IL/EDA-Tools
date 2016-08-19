namespace Elicon.Domain.Netlist
{
    public enum InstanceType
    {
        Unknown = 0,
        Native,
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
        }

        public Instance(Instance instance)
        {
            Id = instance.Id;
            Netlist = instance.Netlist;
            HostModuleName = instance.HostModuleName;
            ModuleName = instance.ModuleName;
            InstanceName = instance.InstanceName;
            Type = instance.Type;
        }


        public long Id { get; set; }
        public string Netlist { get; set; }
        public string HostModuleName { get; set; }
        public string ModuleName { get; set; }
        public string InstanceName { get; set; }
        public InstanceType Type { get; set; }
        public bool IsModule => Type == InstanceType.Module;   
    
    }
}
