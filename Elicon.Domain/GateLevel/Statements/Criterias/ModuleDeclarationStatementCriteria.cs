using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Statements.Criterias
{
    public class ModuleDeclarationStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string statement)
        {
            return statement.FirstTokenIs("module");
        }
    }
}