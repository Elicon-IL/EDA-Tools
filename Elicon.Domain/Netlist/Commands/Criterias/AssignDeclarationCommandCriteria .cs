using Elicon.Framework;

namespace Elicon.Domain.Netlist.Commands.Criterias
{
    public class AssignDeclarationCommandCriteria : ICommandCriteria
    {
        private const string AssignKeyWord = "assign";

        public bool IsSatisfied(string commnad)
        {
            return commnad.FirstTokenIs(AssignKeyWord);
        }

        public CommandType CommandType => CommandType.AssignDeclaration;
    }
}