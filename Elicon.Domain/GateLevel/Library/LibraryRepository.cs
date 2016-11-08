using System.Collections.Generic;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Library
{

    public interface ILibraryRepository
    {
        void Add(string libraryName, Library library);
        Library Get(string libraryName);
        void Remove(string libraryName);
        bool Exists(string libraryName);
    }

    public class LibraryRepository : ILibraryRepository
    {
        private readonly Dictionary<string, Library> _libraries = new Dictionary<string, Library>();

        public void Add(string libraryName, Library library)
        {
            _libraries.Add(libraryName, library);
        }

        public Library Get(string libraryName)
        {
            return _libraries.ValueOrDefault(libraryName);
        }

        public void Remove(string libraryName)
        {
            if (Exists(libraryName))
                _libraries.Remove(libraryName);
        }

        public bool Exists(string libraryName)
        {
            return _libraries.ContainsKey(libraryName);
        }
    }
}