using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface IModuleRepository
    {
        void AddModule(Module module);
        void Update(Module module);
        bool Exists(string netlist, string moduleName);
        Module Get(string netlist, string moduleName);
        IEnumerable<Module> GetAll(string netlist);
    }
}