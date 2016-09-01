using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface IInstanceRepository
    {
        void Add(Instance instance);
        void Update(Instance instance);
        void Update(IEnumerable<Instance> instances);
        IEnumerable<Instance> GetByHostModule(string netlist, string hostModuleName);
        IEnumerable<Instance> GetByModuleName(string netlist, string moduleName);
        IEnumerable<Instance> GetBy(string netlist);
        IEnumerable<Instance> GetNativeInstances(string netlist);
        void Remove(Instance instance);
        void RemoveAll(string netlist);
       
    }
}