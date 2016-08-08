using System.Collections.Generic;

namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface IInstanceModuleRelationRepository
    {
        void Add(long instanceId, string moduleName);
        IEnumerable<long> GetModuleInstances(string moduleName);
    }
}