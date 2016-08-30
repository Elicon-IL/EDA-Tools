using System.Collections.Generic;
using System.Linq;

namespace Elicon.Domain.GateLevel
{
    public class Module
    {
        public Module(Module module)
        {
            Id = module.Id;
            Name = module.Name;
            Netlist = module.Netlist;
            Ports = module.Ports.Select(p => new Port(p)).ToList();
            SupplyDeclarations = module.SupplyDeclarations.ToList();
            AssignDeclarations = module.AssignDeclarations.ToList();
        }

        public Module(string netlist, string name)
        {
            Name = name;
            Netlist = netlist;
            SupplyDeclarations = new List<string>();
            AssignDeclarations = new List<string>();
            Ports = new List<Port>();
        }

        public long Id { get; set; }
        public string Name { get; set; }
        public string Netlist { get; set; }
        public IList<Port> Ports { get; set; }
        public IList<string> SupplyDeclarations { get; set; }
        public IList<string> AssignDeclarations { get; set; }
    }

    public static class ModuleExtensions
    {
        public static bool HasPort(this Module target, string portName)
        {
            return target.Ports.Any(p => p.PortName == portName);
        }
    }
}

