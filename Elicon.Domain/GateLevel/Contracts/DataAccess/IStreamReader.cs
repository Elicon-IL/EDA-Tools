namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface IStreamReader
    {
        string ReadLine();
        string ReadToEnd();
        void Close();
    }
}