using System.Collections.Generic;
using System.Linq;

namespace Elicon.Domain.Netlist
{
    public class Netlist
    {
        public Netlist(Netlist netlist)
        {
            Id = netlist.Id;
            Source = netlist.Source;
            MetaStatements = netlist.MetaStatements.ToList();
        }

        public Netlist(string source)
        {
            Source = source;
            MetaStatements = new List<string>();
        }

        public long Id { get; set; }
        public string Source { get; set; }
        public IList<string> MetaStatements { get; set; }
   }
}

