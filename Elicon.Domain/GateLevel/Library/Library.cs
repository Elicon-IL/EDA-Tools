using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Library
{
    public class Library : ILibrary
    {
        private readonly Dictionary<string, LibraryGate> _edaToolsLibraryGates;

        public Library(Dictionary<string, LibraryGate> libraryGates) 
        {
            _edaToolsLibraryGates = libraryGates;
        }

        public LibraryGate GetGate(string gateName)
        {
            LibraryGate libraryGate;
            return _edaToolsLibraryGates.TryGetValue(gateName, out libraryGate) ? libraryGate : null;
        }

        public void AddGate(LibraryGate libraryGate)
        {
            LibraryGate oldLibraryGate;
            if (_edaToolsLibraryGates.TryGetValue(libraryGate.Name, out oldLibraryGate))
                _edaToolsLibraryGates.Remove(libraryGate.Name);
            _edaToolsLibraryGates.Add(libraryGate.Name, libraryGate);
        }

    }

}
