using System.Collections.Generic;

namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface IModuleRepository
    {
        void Add(Module module);
        Module Get(string moduleName);
        IEnumerable<Module> GetAll();
    }
}