namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface IFileWriter
    {
        void Write(string dest, string action, string content);
    }
}