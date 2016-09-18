using System.Collections.Generic;
using System.Linq;
using System.Text;
using Elicon.Domain.GateLevel;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write.Netlist
{
    public class NetlistFileBuilder : INetlistFileBuilder
    {
        private readonly StringBuilder _result = new StringBuilder();
        private const string ItemsSeparator = " , ";

        public void BuildInstanceDeclaration(Instance instance)
        {
            var net = ItemsSeparator.Join(instance.Net.Select(pwp => "." + pwp.Port + " ( " + pwp.Wire + " )"));
     
            _result.AppendLine(instance.ModuleName + " " + instance.InstanceName + " ( " + net + " );");
        }

        public void BuildEndModule()
        {
            _result.AppendLine("endmodule");
        }

        public void BuildModulePortDeclarations(Module module)
        {
            BuildSpecificPortTypeDeclaration(module.Ports, PortType.Input, "input");
            BuildSpecificPortTypeDeclaration(module.Ports, PortType.Output, "output");
            BuildSpecificPortTypeDeclaration(module.Ports, PortType.Inout, "inout");
        }

        public void BuildSupplyDeclarations(Module module)
        {
            foreach (var supplyDeclaration in module.SupplyDeclarations)
                _result.AppendLine(supplyDeclaration);
        }

        public void BuildModuleDeclaration(Module module)
        {
            var ports = ItemsSeparator.Join(module.Ports.Select(p => p.PortName));
            
            _result.AppendLine("module " + module.Name + " ( " + ports + " );");
        }

        public void BuildMetaStatements(Domain.GateLevel.Netlist netlist)
        {
            foreach (var metaStatement in netlist.MetaStatements)
                _result.AppendLine(metaStatement);
        }

        public void BuildNewLine()
        {
            _result.AppendLine();
        }

        public string GetResult()
        {
            return _result.ToString();
        }

        private void BuildSpecificPortTypeDeclaration(IList<Port> modulePorts, PortType portType, string title)
        {
            var ports = ItemsSeparator.Join(modulePorts.Where(p => p.PortType == portType).Select(p => p.PortName));
        
            if (ports.Length > 0)
                _result.AppendLine(title + " " + ports + ";");
        }
    }

    public interface INetlistFileBuilder
    {
        void BuildInstanceDeclaration(Instance instance);
        void BuildEndModule();
        void BuildModulePortDeclarations(Module module);
        void BuildSupplyDeclarations(Module module);
        void BuildModuleDeclaration(Module module);
        void BuildMetaStatements(Domain.GateLevel.Netlist netlist);
        void BuildNewLine();
        string GetResult();
    }
}