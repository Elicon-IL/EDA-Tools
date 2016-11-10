using Elicon.Domain.GateLevel.VendorLibraryGates;

namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface ILibraryRepository
    {
        void Add(Library library);
        Library Get(string source);
        void Remove(string source);
        bool Exists(string source);
    }
}