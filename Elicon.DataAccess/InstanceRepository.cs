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
            _instances.Add(instance.Id, new Instance(instance));
        }

        public void Update(Instance instance)
        {
            _instances[instance.Id] = new Instance(instance);
        }

        public void Update(IEnumerable<Instance> instances)
        {
            foreach (var instance in instances)
                Update(instance);
        }

        public IEnumerable<Instance> GetByHostModule(string netlist, string hostModuleName)
        {
            return _instances.Values
                .Where(i => i.Netlist == netlist)
                .Where(i => i.HostModuleName == hostModuleName)
                .Select(i => new Instance(i))
                .ToArray();
        }

        public IEnumerable<Instance> GetByModuleName(string netlist, string moduleName)
        {
            return _instances.Values
                 .Where(i => i.Netlist == netlist)
                 .Where(i => i.ModuleName == moduleName)
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

        public IEnumerable<Instance> GetNativeInstances(string netlist)
        {
            return _instances.Values
                 .Where(i => i.Netlist == netlist && !i.IsModule())
                 .Select(i => new Instance(i))
                 .ToArray();
        }

        public void Remove(Instance instance)
        {
            _instances.Remove(instance.Id);
        }

        public void RemoveAll(string netlist)
        {
            foreach (var instance in GetBy(netlist))
                _instances.Remove(instance.Id);
        }
    }
}