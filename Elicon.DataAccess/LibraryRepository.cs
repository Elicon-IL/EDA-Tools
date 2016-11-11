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
            _libraries.Add(library.Id, new Library(library));
        }

        public Library Get(string source)
        {
            var result =_libraries.Values.SingleOrDefault(lib => lib.Source == source);

            if (result != null)
                return new Library(result);

            return null;
        }

        public IList<Library> GetAll()
        {
            return _libraries.Values.Select(lib => new Library(lib)).ToList();
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