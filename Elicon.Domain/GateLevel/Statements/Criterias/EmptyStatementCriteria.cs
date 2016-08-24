using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Statements.Criterias
{
    public class EmptyStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string statement)
        {
            return statement.IsNullOrEmpty();
        }
    }
}