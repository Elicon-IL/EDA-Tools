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
        public Instance(string cellName, string instanceName)
        {
            CellName = cellName;
            InstanceName = instanceName;
        }

        public long Id { get; set; }
        public string CellName { get; set; }
        public string InstanceName { get; set; }
        public InstanceType Type { get; set; }
        public bool IsModule => Type == InstanceType.Module;
        
    }
}
