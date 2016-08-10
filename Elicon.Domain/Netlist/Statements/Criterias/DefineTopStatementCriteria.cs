namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class DefineTopStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string commnad)
        {
            return commnad.StartsWith("`define");
        }
    }
}