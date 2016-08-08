using Elicon.Domain.Netlist.Commands;
using Elicon.Domain.Netlist.Commands.Criterias;

namespace Elicon.Domain.Netlist.Parse.Helpers
{
    public class EndModuleCommandParser
    {
        public CommandType CommandType => new EndModuleCommandCriteria().CommandType;

        public bool CanParse(string command)
        {
            return new EndModuleCommandCriteria().IsSatisfied(command);
        }

        public string Get(string command)
        {
            return null;
        }
    }
}