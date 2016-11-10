using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.VendorLibraryGates
{
    public class Library
    {
        public long Id { get; set; }
        public string Source { get; set; }
        public IList<LibraryGate> Gates { get; set; }
    }

 }
