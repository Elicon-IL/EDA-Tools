using System;
using Elicon.Framework;

namespace Elicon.Domain.Netlist.Parse
{
    public class ModuleDeclarationStatementParser
    {
        public string GetModuleName(string statement)
        {
            statement = statement.KeepFromFirst(' ');
            if (statement.IsEscaped())
                return statement.KeepUntilFirst(' ');

            return statement.KeepUntilFirst('(');
        }
    }
}