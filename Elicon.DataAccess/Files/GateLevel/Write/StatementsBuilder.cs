using System.Text;
using Elicon.Domain.GateLevel;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write
{
    public class StatementsBuilder : IStatementBuilder
    {
        private readonly StringBuilder _result = new StringBuilder();

        public void BuildInstanceDeclaration(Instance instance)
        {
            var net = new StringBuilder("( ");
            foreach (var portWirePair in instance.Net)
                net.Append("." + portWirePair.Port + "( " + portWirePair.Wire + " ), ");

            _result.AppendLine(instance.ModuleName + " " + instance.InstanceName + " " + RemoveLastComma(net) + " );");
        }

        private string RemoveLastComma(StringBuilder net)
        {
            return net.ToString().KeepUntilLast(", ");
        }

        public void BuildEndModule()
        {
            _result.AppendLine("endmodule");
        }

        public void BuildPortDeclarations(Module module)
        {
            foreach (var portDeclaration in module.PortDeclarations)
                _result.AppendLine(portDeclaration);
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
            _result.AppendLine("module " + module.Name + " " + module.Ports);
        }

        public void BuildMetaStatements(Netlist netlist)
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
    }

    public interface IStatementBuilder
    {
        void BuildInstanceDeclaration(Instance instance);
        void BuildEndModule();
        void BuildPortDeclarations(Module module);
        void BuildAssignDeclarations(Module module);
        void BuildSupplyDeclarations(Module module);
        void BuildModuleDeclaration(Module module);
        void BuildMetaStatements(Netlist netlist);
        void BuildNewLine();
        string GetResult();
    }
}