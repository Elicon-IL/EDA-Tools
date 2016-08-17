namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface INetlistFileReaderProvider
    {
        INetlistFileReader GetReaderFor(string source);
    }
}