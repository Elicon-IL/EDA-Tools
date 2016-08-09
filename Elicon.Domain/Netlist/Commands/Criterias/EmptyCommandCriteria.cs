using Elicon.Framework;

namespace Elicon.Domain.Netlist.Commands.Criterias
{
    public class EmptyCommandCriteria : ICommandCriteria
    {
        public bool IsSatisfied(string commnad)
        {
            return commnad.IsNullOrEmpty();
        }
    }
}