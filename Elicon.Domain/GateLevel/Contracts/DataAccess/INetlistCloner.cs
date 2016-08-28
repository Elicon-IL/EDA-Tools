namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface INetlistCloner
    {
        void Clone(string source, string newSource);
    }
}