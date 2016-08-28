using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface IInstanceRepository
    {
        void Add(Instance instance);
        void Update(Instance instance);
        IEnumerable<Instance> GetByHostModule(string netlist, string hostModuleName);
        IEnumerable<Instance> GetByModuleName(string netlist, string moduleName);
        IEnumerable<Instance> GetBy(string netlist);
        void RemoveAll(string netlist);
    }
}