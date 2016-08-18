namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface IModuleRepository
    {
        void AddModule(Module module);
        bool Exists(string netlist, string moduleName);
    }
}