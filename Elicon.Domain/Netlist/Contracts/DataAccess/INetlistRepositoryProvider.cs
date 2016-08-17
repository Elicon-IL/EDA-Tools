namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface INetlistRepositoryProvider
    {
        INetlistRepository GetRepositoryFor(string netlist);
        void Dispose(string netlist);
        bool Exists(string netlist);
    }
}