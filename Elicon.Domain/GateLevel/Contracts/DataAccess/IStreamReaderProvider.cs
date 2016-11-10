namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface IStreamReaderProvider
    {
        IStreamReader Get(string source);
    }
}