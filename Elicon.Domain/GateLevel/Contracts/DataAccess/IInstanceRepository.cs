using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface IInstanceRepository
    {
        void Add(Instance instance);
        void Update(Instance instance);
        void UpdateMany(IEnumerable<Instance> instances);
        IList<Instance> GetByHostModule(string netlist, string hostModuleName);
        IList<Instance> GetByModuleName(string netlist, string moduleName);
        IList<Instance> GetBy(string netlist);
        IList<Instance> GetLibraryGateInstances(string netlist);
        void Remove(Instance instance);
        void RemoveAll(string netlist);
       
    }
}