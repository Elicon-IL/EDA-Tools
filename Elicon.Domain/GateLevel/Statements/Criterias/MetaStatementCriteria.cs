namespace Elicon.Domain.GateLevel.Statements.Criterias
{
    public class MetaStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string statement)
        {
            return statement.StartsWith("`");
        }
    }
}