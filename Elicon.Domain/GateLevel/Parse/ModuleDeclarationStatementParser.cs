using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Parse
{
    public class ModuleDeclarationStatementParser
    {
        private readonly PortsParser _portsParser = new PortsParser();

        public string GetModuleName(string trimmedStatement)
        {
            trimmedStatement = trimmedStatement.KeepFromFirstInclusiveAndTrim(' ');
            if (trimmedStatement.IsEscaped())
                return trimmedStatement.KeepUntilFirstExclusiveAndTrim(' ');

            return trimmedStatement.KeepUntilFirstExclusiveAndTrim('(');
        }

        public IList<Port> GetPorts(string trimmedStatement)
        {
            trimmedStatement = trimmedStatement.KeepFromFirstInclusiveAndTrim(' ');

            if (trimmedStatement.IsEscaped())
                trimmedStatement = trimmedStatement.KeepFromFirstInclusiveAndTrim(' ');
            else
                trimmedStatement = trimmedStatement.KeepFromFirstInclusiveAndTrim('(');

            trimmedStatement = RemoveWrappingBracketsAndSemiColon(trimmedStatement);

            return _portsParser.GetPorts(trimmedStatement).ToList();
        }

        private string RemoveWrappingBracketsAndSemiColon(string trimmedStatement)
        {
            return trimmedStatement.RemoveFirstCharAndTrim().KeepUntilLastExclusiveAndTrim(")");
        }
    }
}