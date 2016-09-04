using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public class PortsMapping
    {
        private readonly IDictionary<string, string> _portsMap = new Dictionary<string, string>();

        public PortsMapping AddMapping(string oldPort, string newPort)
        {
            _portsMap.Add(oldPort, newPort);
            return this;
        }

        public bool HasMappingFor(string port)
        {
            return _portsMap.ContainsKey(port);
        }

        public string Map(string port)
        {
            return _portsMap[port];
        }
    }
}