using System;

namespace Elicon.Domain.Netlist.Read
{
    public interface ICommandTrimmer
    {
        string Trim(string command);
    }

    public class CommandTrimmer : ICommandTrimmer
    {
        public string Trim(string command)
        {
            if (command.Contains("//"))
                return command
                    .Substring(0, command.IndexOf("//", StringComparison.Ordinal))
                    .Trim();

            return command.Trim();
        }
    }
}