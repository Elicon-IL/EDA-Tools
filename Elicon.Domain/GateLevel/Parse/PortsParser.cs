using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Parse
{
    public class PortsParser
    {
        private readonly PortsTokenizer _portsTokenizer = new PortsTokenizer();

        public IEnumerable<Port> GetPorts(string statement)
        {
            var request = new PortsTokenizeRequest(statement) { IsPortList = true };

            while (_portsTokenizer.HasNext(request))
            {
                var portToken = _portsTokenizer.NextToken(request);
                if (portToken == null)
                    yield break;
                yield return new Port(portToken);
            }
        }
    }
}