namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface INetlistRepository
    {
        void Add(string netlist);
        bool Exists(string netlist);
    }
}