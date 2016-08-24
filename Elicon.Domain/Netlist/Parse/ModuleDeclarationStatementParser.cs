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

        public string GetPorts(string statement)
        {
            statement = statement.KeepFromFirst(' ');
            if (statement.IsEscaped())
                return statement.KeepFromFirst(' ');

            return statement.KeepFromFirst('(');
        }
    }
}