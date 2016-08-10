namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public interface IStatementCriteria
    {
        bool IsSatisfied(string commnad);
    }
}