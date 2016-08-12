using System.Collections.Generic;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class InstanceModuleRelationRepository : IInstanceModuleRelationRepository
    {
        private readonly Dictionary<string, List<long>> _map = new Dictionary<string, List<long>>();

        public void Add(long instanceId, string moduleName)
        {
            if (!_map.ContainsKey(moduleName))
                _map.Add(moduleName, new List<long>());

            _map[moduleName].Add(instanceId);
        }

        public IEnumerable<long> GetModuleInstances(string moduleName)
        {
            if (!_map.ContainsKey(moduleName))
                return new List<long>();

            return _map[moduleName];
        }

    }
}