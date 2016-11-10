using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.VendorLibraryGates;

namespace Elicon.DataAccess
{
    public class LibraryRepository : ILibraryRepository
    {
        private readonly Dictionary<long, Library> _libraries = new Dictionary<long, Library>();
        private readonly IIdGenerator _idGenerator;

        public LibraryRepository(IIdGenerator idGenerator)
        {
            _idGenerator = idGenerator;
        }

        public void Add(Library library)
        {
            library.Id = _idGenerator.GenerateId();
            _libraries.Add(library.Id, library);
        }

        public Library Get(string source)
        {
            return _libraries.Values.SingleOrDefault(lib => lib.Source == source);
        }
        
        public void Remove(string source)
        {
            var key = _libraries.Single(kvp => kvp.Value.Source == source).Key;
            _libraries.Remove(key);
        }

        public bool Exists(string source)
        {
            return _libraries.Values.Any(lib => lib.Source == source);
        }
    }
}