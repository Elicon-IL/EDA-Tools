using System;
using Elicon.Framework;

namespace Elicon.Domain.Netlist.Parse
{
    public class ModuleDeclarationStatementParser
    {
        public string GetModuleName(string statement)
        {
            // Remove the word module from the line.
            var result = statement.Substring(statement.IndexOf(' ')).Trim();

            // Escaped name always ends with space.
            if (result.IsEscaped())
                return result.Substring(0, result.IndexOf(' ')).Trim();

            // Module name is always followed by warping '(' of the module ports list.
            return result.Substring(0, result.IndexOf('(')).Trim();
        }
    }
}