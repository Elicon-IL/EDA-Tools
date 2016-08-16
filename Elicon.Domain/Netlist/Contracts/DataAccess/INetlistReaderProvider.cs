namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface INetlistReaderProvider
    {
        INetlistReader GetReaderFor(string source);
    }
}