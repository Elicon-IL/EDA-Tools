using System.Collections.Generic;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class NetlistRepository : INetlistRepository
    {
        private readonly HashSet<string> _netlists = new HashSet<string>();
        
        public void Add(string netlist)
        {
            _netlists.Add(netlist);
        }

        public bool Exists(string netlist)
        {
            return _netlists.Contains(netlist);
        }
    }
}