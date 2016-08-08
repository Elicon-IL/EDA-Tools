using Elicon.Framework;

namespace Elicon.Domain.Netlist.Commands.Criterias
{
    public class ModuleDeclarationCommandCriteria : ICommandCriteria
    {
        public bool IsSatisfied(string commnad)
        {
            return commnad.FirstTokenIs("module");
        }

        public CommandType CommandType => CommandType.ModuleDeclaration;
    }
}