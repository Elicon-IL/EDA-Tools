using System;

namespace Elicon.Domain.Netlist.Parse
{
    public class ModuleDeclarationStatementParser
    {
        public string GetModuleName(string statement)
        {
            // Remove the word module from the line.
            var result = statement.Substring(statement.IndexOf(" ", StringComparison.Ordinal)).Trim();

            // Escaped name always ends with space.
            if (result.StartsWith("\\"))
                return result.Substring(0, result.IndexOf(" ", StringComparison.Ordinal)).Trim();

            // Module name is always followed by warping '(' of the module ports list.
            return result.Substring(0, result.IndexOf("(", StringComparison.Ordinal)).Trim();
        }
    }
}