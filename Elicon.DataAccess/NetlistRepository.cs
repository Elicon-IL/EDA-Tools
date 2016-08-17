using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.Netlist;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class NetlistRepository : INetlistRepository
    {
        private readonly Dictionary<long, Instance> _instances = new Dictionary<long, Instance>();
        private readonly Dictionary<string, Module> _modules = new Dictionary<string, Module>();
        private readonly Dictionary<string, List<long>> _moduleToInstancesMap = new Dictionary<string, List<long>>();
        private readonly List<string> _metaStatements = new List<string>();

        private readonly IIdGenerator _idGenerator;

        public NetlistRepository(IIdGenerator idGenerator)
        {
            _idGenerator = idGenerator;
        }

        public void AddInstance(Instance instance, string moduleName)
        {
            instance.Id = _idGenerator.GenerateId();
            _instances.Add(instance.Id, instance);

            if (!_moduleToInstancesMap.ContainsKey(moduleName))
                _moduleToInstancesMap.Add(moduleName, new List<long>());

            _moduleToInstancesMap[moduleName].Add(instance.Id);
        }

        public void UpdateInstance(Instance instance)
        {
            _instances[instance.Id] = instance;
        }

        public IEnumerable<Instance> GetModuleInstances(string moduleName)
        {
            var instanceIds = _moduleToInstancesMap[moduleName];

            return GetInstancesByIds(instanceIds);
        }

        public IEnumerable<Instance> GetAllInstances()
        {
            return _instances.Values.ToArray();
        }

        public void AddModule(Module module)
        {
            _modules.Add(module.Name, module);
        }

        public bool Exists(string moduleName)
        {
            return _modules.ContainsKey(moduleName);
        }

        public void AddMetaStatement(string metaStatement)
        {
            _metaStatements.Add(metaStatement);
        }

        public IEnumerable<string> GetAllMetaStatement()
        {
            return _metaStatements;
        }

        private IEnumerable<Instance> GetInstancesByIds(IEnumerable<long> ids)
        {
            var set = new HashSet<long>(ids.ToArray());

            return _instances
                .Where(kvp => set.Contains(kvp.Key))
                .Select(kvp => kvp.Value)
                .ToArray();
        }
    }
}