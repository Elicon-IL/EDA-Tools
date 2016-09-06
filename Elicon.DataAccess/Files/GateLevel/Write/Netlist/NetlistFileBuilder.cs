using System.Collections.Generic;
using System.Linq;
using System.Text;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write.Netlist
{
    public class NetlistFileBuilder : INetlistFileBuilder
    {
        private readonly IFileTitleBuilder _fileTitleBuilder;
        private readonly INetlistRepository _netlistRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceRepository _instanceRepository;
        private const string ItemsSeparator = ", ";

        public NetlistFileBuilder(IFileTitleBuilder fileTitleBuilder, INetlistRepository netlistRepository, IModuleRepository moduleRepository, IInstanceRepository instanceRepository)
        {
            _fileTitleBuilder = fileTitleBuilder;
            _netlistRepository = netlistRepository;
            _moduleRepository = moduleRepository;
            _instanceRepository = instanceRepository;
        }
        
        public string Build(string source, string action)
        {
            var result = new StringBuilder();

            var netlist = _netlistRepository.Get(source);
            var modules = _moduleRepository.GetAll(source);

            BuildTitle(result, action);
            BuildMetaStatements(result, netlist);

            foreach (var module in modules)
            {
                BuildModuleDeclaration(result, module);
                BuildNewLine(result);
                BuildPortDeclarations(result, module);
                BuildSupplyDeclarations(result, module);
                BuildAssignDeclarations(result,module);

                foreach (var instance in _instanceRepository.GetByHostModule(source, module.Name))
                    BuildInstanceDeclaration(result, instance);

                BuildEndModule(result);
                BuildNewLine(result);
            }

            return result.ToString();
        }

        private void BuildTitle(StringBuilder result, string action)
        {
            result.AppendLine(_fileTitleBuilder.BuildTitle(action));
        }

        private void BuildInstanceDeclaration(StringBuilder result, Instance instance)
        {
            var net = new StringBuilder();
            foreach (var portWirePair in instance.Net)
                net.Append("." + portWirePair.Port + "( " + portWirePair.Wire + " )" + ItemsSeparator);

            result.AppendLine(instance.ModuleName + " " + instance.InstanceName + " " + "( " + RemoveLastItemsSeparator(net) + " );");
        }

        private void BuildEndModule(StringBuilder result)
        {
            result.AppendLine("endmodule");
        }

        public void BuildPortDeclarations(StringBuilder result, Module module)
        {
            BuildSpecificPortTypeDeclaration(result, module.Ports, PortType.Input, "input");
            BuildSpecificPortTypeDeclaration(result, module.Ports, PortType.Output, "output");
            BuildSpecificPortTypeDeclaration(result, module.Ports, PortType.Inout, "inout");
        }

        private void BuildAssignDeclarations(StringBuilder result, Module module)
        {
            foreach (var assignDeclaration in module.AssignDeclarations)
                result.AppendLine(assignDeclaration);
        }

        private void BuildSupplyDeclarations(StringBuilder result, Module module)
        {
            foreach (var supplyDeclaration in module.SupplyDeclarations)
                result.AppendLine(supplyDeclaration);
        }

        private void BuildModuleDeclaration(StringBuilder result, Module module)
        {
            var ports = new StringBuilder();
            foreach (var port in module.Ports)
                ports.Append(port.PortName + ItemsSeparator);

            result.AppendLine("module " + module.Name + " " + "( " + RemoveLastItemsSeparator(ports) + " );");
        }

        private void BuildMetaStatements(StringBuilder result, Domain.GateLevel.Netlist netlist)
        {
            foreach (var metaStatement in netlist.MetaStatements)
                result.AppendLine(metaStatement);
        }

        private void BuildNewLine(StringBuilder result)
        {
            result.AppendLine();
        }

        private string RemoveLastItemsSeparator(StringBuilder sb)
        {
            return sb.ToString().KeepUntilLastExclusiveAndTrim(ItemsSeparator);
        }

        private void BuildSpecificPortTypeDeclaration(StringBuilder result, IList<Port> modulePorts, PortType portType, string title)
        {
            var ports = new StringBuilder();

            foreach (var port in modulePorts.Where(p => p.PortType == portType))
                ports.Append(port.PortName + ItemsSeparator);

            if (ports.Length > 0)
                result.AppendLine(title + " " + RemoveLastItemsSeparator(ports) + ";");
        }
    }

    public interface INetlistFileBuilder
    {
        string Build(string source, string action);
    }
}