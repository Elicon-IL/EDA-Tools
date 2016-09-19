namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface INetlistFileReader
    {
        string ReadTrimmedStatement();
        void Close();
    }
}