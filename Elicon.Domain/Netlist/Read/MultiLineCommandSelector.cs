using System.Linq;
using Elicon.Domain.Netlist.Commands.Criterias;

namespace Elicon.Domain.Netlist.Read
{
    public interface IMultiLineCommandSelector
    {
        bool IsMultiLineCommand(string commnad);
    }

    public class MultiLineCommandSelector : IMultiLineCommandSelector
    {
        private readonly ICommandCriteria[] _multiLineCommandsCounterSet = {
            new EmptyCommandCriteria(), new EndModuleCommandCriteria(), new DefineTopCommandCriteria()
        };
        
        public bool IsMultiLineCommand(string commnad)
        {
            if (commnad.EndsWith(";"))
                return false;

            return !_multiLineCommandsCounterSet
                    .Any(criteria => criteria.IsSatisfied(commnad));
        }
    }
}