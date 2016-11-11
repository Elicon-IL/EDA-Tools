using System.Collections.Generic;
using Elicon.Domain.GateLevel.VendorLibraryGates;

namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface ILibraryRepository
    {
        void Add(Library library);
        Library Get(string source);
        IList<Library> GetAll();
        void Remove(string source);
        bool Exists(string source);
    }
}