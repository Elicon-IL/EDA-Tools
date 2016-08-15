using Elicon.Framework;

namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class MetaStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string statement)
        {
            return statement.StartsWith("`");
        }
    }
}