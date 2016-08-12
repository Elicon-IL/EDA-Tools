using Elicon.Framework;

namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class ModuleDeclarationStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string statement)
        {
            return statement.FirstTokenIs("module");
        }
    }
}