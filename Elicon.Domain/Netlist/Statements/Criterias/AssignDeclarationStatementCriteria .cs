using Elicon.Framework;

namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class AssignDeclarationStatementCriteria : IStatementCriteria
    {
        private const string AssignKeyWord = "assign";

        public bool IsSatisfied(string statement)
        {
            return statement.FirstTokenIs(AssignKeyWord);
        }
    }
}