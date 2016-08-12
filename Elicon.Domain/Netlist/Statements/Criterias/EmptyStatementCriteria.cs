using Elicon.Framework;

namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class EmptyStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string statement)
        {
            return statement.IsNullOrEmpty();
        }
    }
}