namespace Elicon.Domain.Netlist
{
    public class Module
    {
        public Module(string netlist, string name)
        {
            Name = name;
            Netlist = netlist;
        }
        public long Id { get; set; }
        public string Name { get; set; }
        public string Netlist { get; set; }
    }
}
