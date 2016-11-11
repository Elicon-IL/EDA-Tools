using System.Collections.Generic;
using System.Linq;

namespace Elicon.Domain.GateLevel.VendorLibraryGates
{
    public class Library
    {
        public long Id { get; set; }
        public string Source { get; set; }
        public IList<LibraryGate> Gates { get; set; }

        public Library(){}

        public Library(Library library)
        {
            Id = library.Id;
            Source = library.Source;
            Gates = library.Gates.Select(gate => new LibraryGate(gate)).ToList();
        }
    }
 }
