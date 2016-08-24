using System.Collections.Generic;
using System.Linq;

namespace Elicon.Domain.Netlist
{
    public class Module
    {
        public Module(Module module)
        {
            Id = module.Id;
            Name = module.Name;
            Netlist = module.Netlist;
            PortDeclarations = module.PortDeclarations.ToList();
            SupplyDeclarations = module.SupplyDeclarations.ToList();
        }

        public Module(string netlist, string name)
        {
            Name = name;
            Netlist = netlist;
            PortDeclarations = new List<string>();
            SupplyDeclarations = new List<string>();
        }

        public long Id { get; set; }
        public string Name { get; set; }
        public string Netlist { get; set; }
        public IList<string> PortDeclarations { get; set; }
        public IList<string> SupplyDeclarations { get; set; }
    }
}

