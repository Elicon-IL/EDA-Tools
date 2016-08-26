using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class InstanceRepository : IInstanceRepository
    {
        private readonly Dictionary<long, Instance> _instances = new Dictionary<long, Instance>();

        private readonly IIdGenerator _idGenerator;

        public InstanceRepository(IIdGenerator idGenerator)
        {
            _idGenerator = idGenerator;
        }

        public void Add(Instance instance) 
        {
            instance.Id = _idGenerator.GenerateId();
            _instances.Add(instance.Id, instance);
        }

        public void Update(Instance instance)
        {
            _instances[instance.Id] = new Instance(instance);
        }

        public IEnumerable<Instance> GetBy(string netlist, string moduleName)
        {
            return _instances.Values
                .Where(i => i.Netlist == netlist)
                .Where(i => i.HostModuleName == moduleName)
                .Select(i => new Instance(i))
                .ToArray();
        }

        public IEnumerable<Instance> GetBy(string netlist)
        {
            return _instances.Values
                .Where(i => i.Netlist == netlist)
                .Select(i => new Instance(i))
                .ToArray();
        }
    }
}