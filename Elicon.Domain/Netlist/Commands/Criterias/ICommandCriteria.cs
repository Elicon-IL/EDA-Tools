namespace Elicon.Domain.Netlist.Commands.Criterias
{
    public interface ICommandCriteria
    {
        bool IsSatisfied(string commnad);
        CommandType CommandType { get; }
    }
}