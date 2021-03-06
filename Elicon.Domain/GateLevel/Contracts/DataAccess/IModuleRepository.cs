using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface IModuleRepository
    {
        void Add(Module module);
        void Update(Module module);
        bool Exists(string netlist, string moduleName);
        Module Get(string netlist, string moduleName);
        IList<Module> GetMany(string netlist, IList<string> moduleNames);
        IList<Module> GetAll(string netlist);
        void RemoveAll(string netlist);
    }
}