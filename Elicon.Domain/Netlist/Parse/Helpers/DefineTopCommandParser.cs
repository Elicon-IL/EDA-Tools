using System;
using Elicon.Domain.Netlist.Commands;
using Elicon.Domain.Netlist.Commands.Criterias;

namespace Elicon.Domain.Netlist.Parse.Helpers
{
    public class DefineTopCommandParser
    {
        public CommandType CommandType => CommandType.DefineTop;

        public bool CanParse(string line)
        {
            return new DefineTopCommandCriteria().IsSatisfied(line);
        }

        public string GetTopModuleName(string line)
        {
            line = line.Substring(line.IndexOf(" ", StringComparison.Ordinal)).Trim(); // Remove `define token
            line = line.Substring(line.IndexOf(" ", StringComparison.Ordinal)).Trim(); // Remove top token

            return line;
        }
    }
}