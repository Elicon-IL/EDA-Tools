using System.Collections.Generic;

namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface IInstanceRepository
    {
        void Add(Instance instance, string moduleName);
        void Update(Instance instance);
        IEnumerable<Instance> GetByIds(IEnumerable<long> ids);
        IEnumerable<Instance> GetByModule(string moduleName);
        IEnumerable<Instance> GetAll();
    }
}