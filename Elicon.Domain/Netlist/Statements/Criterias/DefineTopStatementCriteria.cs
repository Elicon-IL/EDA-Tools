namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class DefineTopStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string statement)
        {
            return statement.StartsWith("`define");
        }
    }
}