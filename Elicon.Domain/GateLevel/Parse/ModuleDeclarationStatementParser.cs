using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Parse
{
    public class ModuleDeclarationStatementParser
    {
        private readonly PortsParser _portsParser = new PortsParser();

        public string GetModuleName(string statement)
        {
            statement = statement.KeepFromFirstInclusiveAndTrim(' ');
            if (statement.IsEscaped())
                return statement.KeepUntilFirstExclusiveAndTrim(' ');

            return statement.KeepUntilFirstExclusiveAndTrim('(');
        }

        public IList<Port> GetPorts(string statement)
        {
            statement = statement.KeepFromFirstInclusiveAndTrim(' ');

            if (statement.IsEscaped())
                statement = statement.KeepFromFirstInclusiveAndTrim(' ');
            else
                statement = statement.KeepFromFirstInclusiveAndTrim('(');

            statement = RemoveWrappingBracketsAndSemiColon(statement);

            return _portsParser.GetPorts(statement).ToList();
        }

        private string RemoveWrappingBracketsAndSemiColon(string statement)
        {
            return statement.RemoveFirstCharAndTrim().KeepUntilLastExclusiveAndTrim(")");
        }
    }
}