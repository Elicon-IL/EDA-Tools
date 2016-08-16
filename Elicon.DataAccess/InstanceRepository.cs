using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.Netlist;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class InstanceRepository : IInstanceRepository
    {
        private readonly Dictionary<long, Instance> _instances = new Dictionary<long, Instance>();
        private readonly IIdGenerator _idGenerator;
        private readonly IInstanceModuleRelationRepository _instanceModuleRelationRepository;

        public InstanceRepository(IIdGenerator idGenerator, IInstanceModuleRelationRepository instanceModuleRelationRepository)
        {
            _idGenerator = idGenerator;
            _instanceModuleRelationRepository = instanceModuleRelationRepository;
        }

        public void Add(Instance instance, string moduleName)
        {
            instance.Id = _idGenerator.GenerateId();
            _instances.Add(instance.Id, instance);
            _instanceModuleRelationRepository.Add(instance.Id, moduleName);
        }

        public void Update(Instance instance)
        {
            _instances[instance.Id] = instance;
        }

        public IEnumerable<Instance> GetByIds(IEnumerable<long> ids)
        {
            var set = new HashSet<long>(ids.ToArray());

            return _instances
                .Where(kvp => set.Contains(kvp.Key))
                .Select(kvp => kvp.Value)
                .ToArray();
        }

        public IEnumerable<Instance> GetByModule(string moduleName)
        {
            var instanceIds = _instanceModuleRelationRepository.GetModuleInstances(moduleName);
            return GetByIds(instanceIds);
        }

        public IEnumerable<Instance> GetAll()
        {
            return _instances.Values.ToArray();
        }

        public void Dispose()
        {
            _instances.Clear();
        }
    }
}