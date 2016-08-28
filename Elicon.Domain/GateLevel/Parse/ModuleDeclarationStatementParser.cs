using System.Collections.Generic;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Parse
{
    public class ModuleDeclarationStatementParser
    {
        private readonly PortsParser _portsParser = new PortsParser();

        public string GetModuleName(string statement)
        {
            statement = statement.KeepFromFirst(' ');
            if (statement.IsEscaped())
                return statement.KeepUntilFirst(' ');

            return statement.KeepUntilFirst('(');
        }

        public IList<Port> GetPorts(string statement)
        {
            statement = statement.KeepFromFirst(' ');

            if (statement.IsEscaped())
                statement = statement.KeepFromFirst(' ');
            else
                statement = statement.KeepFromFirst('(');

            statement = RemoveWrappingBracketsAndSemiColon(statement);

            return _portsParser.GetPorts(statement);
        }

        private string RemoveWrappingBracketsAndSemiColon(string statement)
        {
            return statement.RemoveFirstChar().RemoveLastChar().RemoveLastChar();
        }
    }
}