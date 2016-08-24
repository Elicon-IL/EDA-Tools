namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface INetlistFileReaderProvider
    {
        INetlistFileReader GetReaderFor(string source);
    }
}