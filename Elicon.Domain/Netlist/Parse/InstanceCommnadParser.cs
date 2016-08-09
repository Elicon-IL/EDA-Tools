using System;

namespace Elicon.Domain.Netlist.Parse
{
   public class InstanceCommnadParser
    {
        public string GetCellName(string command)
        {
            return command.Substring(0, command.IndexOf(' '));
        }

        public string GeInstanceName(string command)
        {
            // Remove cell name token.
            command = command
                .Substring(command.IndexOf(' '))
                .Trim();

            // Syntax rule : escaped instance name is separated from the connections token
            // by ' '.
            if (command.StartsWith("\\"))
            {
                command = command.Substring(0, command.IndexOf(' '));
            }

            // Instance name token is until the first '('  - which is the warping bracket of the net component.
            else
            {
                command = command.Substring(0, command.IndexOf("(", StringComparison.Ordinal)).Trim();
            }

            return command;
        }
    }
}