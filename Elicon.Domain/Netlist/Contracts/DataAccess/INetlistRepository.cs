using System.Collections.Generic;

namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface INetlistRepository
    {
        void AddInstance(Instance instance, string moduleName);
        void UpdateInstance(Instance instance);
        IEnumerable<Instance> GetByIds(IEnumerable<long> ids);
        IEnumerable<Instance> GetByModule(string moduleName);
        IEnumerable<Instance> GetAllInstances();
        void AddModule(Module module);
        bool Exists(string moduleName);
        void AddMetaStatement(string metaStatement);
        IEnumerable<string> GetAllMetaStatement();
    }
}