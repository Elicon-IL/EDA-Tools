using System.Collections.Generic;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Parse
{
    public class InstanceStatementParser
    {
        private readonly PortsTokenizer _portsTokenizer = new PortsTokenizer();

        public string GetModuleName(string trimmedStatement)
        {
            return trimmedStatement
                .KeepUntilFirstExclusiveAndTrim(' ');
        }

        public string GeInstanceName(string trimmedStatement)
        {
            trimmedStatement = trimmedStatement.KeepFromFirstInclusiveAndTrim(' ');
            if (trimmedStatement.IsEscaped())
                return trimmedStatement.KeepUntilFirstExclusiveAndTrim(' ');

            return trimmedStatement.KeepUntilFirstExclusiveAndTrim('(');
        }

        public IEnumerable<PortWirePair> GetNet(string trimmedStatement)
        {
            var connections = GetNetPartFrom(trimmedStatement);
            var request = new PortsTokenizeRequest(connections);

            while (_portsTokenizer.HasNext(request))
            {
                var portToken = _portsTokenizer.NextToken(request);
                var wireToken = _portsTokenizer.NextToken(request);
                if (portToken == null || wireToken == null)
                    yield break;
                yield return new PortWirePair(portToken, wireToken);
            }
        }
        
        private string GetNetPartFrom(string trimmedStatement)
        {
            trimmedStatement = trimmedStatement.KeepFromFirstInclusiveAndTrim(" ");
            if (trimmedStatement.IsEscaped())
                trimmedStatement = trimmedStatement.KeepFromFirstInclusiveAndTrim(" ");

            return trimmedStatement.KeepFromFirstInclusiveAndTrim("(").RemoveFirstCharAndTrim()
                .KeepUntilLastExclusiveAndTrim(")");        
        }
    }
}