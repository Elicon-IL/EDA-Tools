using System.Collections.Generic;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Parse
{
    public class InstanceStatementParser
    {
        private readonly PortsTokenizer _portsTokenizer = new PortsTokenizer();

        public string GetModuleName(string statement)
        {
            return statement
                .KeepUntilFirstExclusiveAndTrim(' ');
        }

        public string GeInstanceName(string statement)
        {
            statement = statement.KeepFromFirstInclusiveAndTrim(' ');
            if (statement.IsEscaped())
                return statement.KeepUntilFirstExclusiveAndTrim(' ');

            return statement.KeepUntilFirstExclusiveAndTrim('(');
        }

        public IEnumerable<PortWirePair> GetNet(string statement)
        {
            var connections = GetNetPartFrom(statement);
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
        
        private string GetNetPartFrom(string line)
        {
            line = line.KeepFromFirstInclusiveAndTrim(" ");
            if (line.IsEscaped())
                line = line.KeepFromFirstInclusiveAndTrim(" ");

            return line.KeepFromFirstInclusiveAndTrim("(").RemoveFirstCharAndTrim()
                .KeepUntilLastExclusiveAndTrim(")");        
        }
    }
}