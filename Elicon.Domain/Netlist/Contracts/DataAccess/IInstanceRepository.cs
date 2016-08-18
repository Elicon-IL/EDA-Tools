using System.Collections.Generic;

namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface IInstanceRepository
    {
        void AddInstance(Instance instance);
        void UpdateInstance(Instance instance);
        IEnumerable<Instance> GetBy(string netlist, string moduleName);
        IEnumerable<Instance> GetBy(string netlist);
    }
}