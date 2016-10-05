using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Framework;

namespace Elicon.DataAccess
{
    public class InstanceRepository : IInstanceRepository
    {
        private readonly ConcurrentDictionary<long, Instance> _instances = new ConcurrentDictionary<long, Instance>();
        private readonly ConcurrentDictionary<string, List<long>> _hostModuleToInstancesMap = new ConcurrentDictionary<string, List<long>>();
        private readonly IIdGenerator _idGenerator;

        public InstanceRepository(IIdGenerator idGenerator)
        {
            _idGenerator = idGenerator;
        }

        public void Add(Instance instance)
        {
            instance.Id = _idGenerator.GenerateId();
            _instances.TryAdd(instance.Id, new Instance(instance));
            _hostModuleToInstancesMap.ValueOrNew(instance.HostModuleName).Add(instance.Id);
        }

        public void Update(Instance instance)
        {
            if (instance.HostModuleName != _instances[instance.Id].HostModuleName)
                throw new InvalidOperationException("Instance object host module name field is not updateble.");

            _instances[instance.Id] = new Instance(instance);
        }

        public void UpdateMany(IEnumerable<Instance> instances)
        {
            foreach (var instance in instances)
                Update(instance);
        }

        public IList<Instance> GetByHostModule(string netlist, string hostModuleName)
        {
            return _hostModuleToInstancesMap.ValueOrNew(hostModuleName)
                .Select(id => _instances[id])
                .Where(instance => instance.Netlist == netlist)
                .Select(instance => new Instance(instance))
                .ToArray();
        }

        public IList<Instance> GetByModuleName(string netlist, string moduleName)
        {
            return _instances.Values
                 .Where(i => i.Netlist == netlist)
                 .Where(i => i.ModuleName == moduleName)
                 .Select(i => new Instance(i))
                 .ToArray();
        }

        public IList<Instance> GetBy(string netlist)
        {
            return _instances.Values
                .Where(i => i.Netlist == netlist)
                .Select(i => new Instance(i))
                .ToArray();
        }

        public IList<Instance> GetLibraryGateInstances(string netlist)
        {
            return _instances.Values
                 .Where(i => i.Netlist == netlist && !i.IsModule())
                 .Select(i => new Instance(i))
                 .ToArray();
        }

        public void Remove(Instance instance)
        {
            Instance value;
            _instances.TryRemove(instance.Id, out value);
            _hostModuleToInstancesMap.ValueOrNew(instance.HostModuleName).Remove(instance.Id);
        }

        public void RemoveAll(string netlist)
        {
            foreach (var instance in GetBy(netlist))
                Remove(instance);
        }
    }
}