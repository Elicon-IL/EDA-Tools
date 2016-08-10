using Elicon.Framework;

namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class ModuleDeclarationStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string commnad)
        {
            return commnad.FirstTokenIs("module");
        }
    }
}