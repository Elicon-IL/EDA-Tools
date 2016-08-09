namespace Elicon.Domain.Netlist.Commands.Criterias
{
    public class DefineTopCommandCriteria : ICommandCriteria
    {
        public bool IsSatisfied(string commnad)
        {
            return commnad.StartsWith("`define");
        }
    }
}