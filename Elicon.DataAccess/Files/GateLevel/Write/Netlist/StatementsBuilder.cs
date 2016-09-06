using System.Collections.Generic;
using System.Linq;
using System.Text;
using Elicon.Domain.GateLevel;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write.Netlist
{
    public class StatementsBuilder : IStatementBuilder
    {
        private readonly StringBuilder _result = new StringBuilder();
        private const string ItemsSeparator = ", ";

        public void BuildInstanceDeclaration(Instance instance)
        {
            var net = new StringBuilder();
            foreach (var portWirePair in instance.Net)
                net.Append("." + portWirePair.Port + "( " + portWirePair.Wire + " )" + ItemsSeparator);

            _result.AppendLine(instance.ModuleName + " " + instance.InstanceName + " " + "( " + RemoveLastItemsSeparator(net) + " );");
        }

        public void BuildEndModule()
        {
            _result.AppendLine("endmodule");
        }

        public void BuildPortDeclarations(Module module)
        {
            BuildSpecificPortTypeDeclaration(module.Ports, PortType.Input, "input");
            BuildSpecificPortTypeDeclaration(module.Ports, PortType.Output, "output");
            BuildSpecificPortTypeDeclaration(module.Ports, PortType.Inout, "inout");
        }

        public void BuildAssignDeclarations(Module module)
        {
            foreach (var assignDeclaration in module.AssignDeclarations)
                _result.AppendLine(assignDeclaration);
        }

        public void BuildSupplyDeclarations(Module module)
        {
            foreach (var supplyDeclaration in module.SupplyDeclarations)
                _result.AppendLine(supplyDeclaration);
        }

        public void BuildModuleDeclaration(Module module)
        {
            var ports = new StringBuilder();
            foreach (var port in module.Ports)
                ports.Append(port.PortName + ItemsSeparator);

            _result.AppendLine("module " + module.Name + " " + "( " + RemoveLastItemsSeparator(ports) + " );");
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

        private string RemoveLastItemsSeparator(StringBuilder sb)
        {
            return sb.ToString().KeepUntilLastExclusiveAndTrim(ItemsSeparator);
        }

        private void BuildSpecificPortTypeDeclaration(IList<Port> modulePorts, PortType portType, string title)
        {
            var ports = new StringBuilder();

            foreach (var port in modulePorts.Where(p => p.PortType == portType))
                ports.Append(port.PortName + ItemsSeparator);

            if (ports.Length > 0)
                _result.AppendLine(title + " " + RemoveLastItemsSeparator(ports) + ";");
        }
    }

    public interface IStatementBuilder
    {
        void BuildInstanceDeclaration(Instance instance);
        void BuildEndModule();
        void BuildPortDeclarations(Module module);
        void BuildAssignDeclarations(Module module);
        void BuildSupplyDeclarations(Module module);
        void BuildModuleDeclaration(Module module);
        void BuildMetaStatements(Domain.GateLevel.Netlist netlist);
        void BuildNewLine();
        string GetResult();
    }
}