namespace Elicon.Domain.GateLevel.Statements.Criterias
{
    public interface IStatementCriteria
    {
        bool IsSatisfied(string statement);
    }
}