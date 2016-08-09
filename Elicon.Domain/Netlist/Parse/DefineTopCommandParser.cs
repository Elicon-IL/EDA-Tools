using System;

namespace Elicon.Domain.Netlist.Parse
{
    public class DefineTopCommandParser
    {
        public string GetTopModuleName(string line)
        {
            line = line.Substring(line.IndexOf(" ", StringComparison.Ordinal)).Trim(); // Remove `define token
            line = line.Substring(line.IndexOf(" ", StringComparison.Ordinal)).Trim(); // Remove top token

            return line;
        }
    }
}