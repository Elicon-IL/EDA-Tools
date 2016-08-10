using System;

namespace Elicon.Domain.Netlist.Parse
{
   public class InstanceStatementParser
    {
        public string GetCellName(string statement)
        {
            return statement.Substring(0, statement.IndexOf(' '));
        }

        public string GeInstanceName(string statement)
        {
            // Remove cell name token.
            statement = statement
                .Substring(statement.IndexOf(' '))
                .Trim();

            // Syntax rule : escaped instance name is separated from the connections token
            // by ' '.
            if (statement.StartsWith("\\"))
            {
                statement = statement.Substring(0, statement.IndexOf(' '));
            }

            // Instance name token is until the first '('  - which is the warping bracket of the net component.
            else
            {
                statement = statement.Substring(0, statement.IndexOf("(", StringComparison.Ordinal)).Trim();
            }

            return statement;
        }
    }
}