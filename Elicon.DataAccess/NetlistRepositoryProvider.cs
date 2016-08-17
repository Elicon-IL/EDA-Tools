using System.Collections.Generic;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class NetlistRepositoryProvider : INetlistRepositoryProvider
    { 
        private readonly Dictionary<string, INetlistRepository> _repos = new Dictionary<string, INetlistRepository>();
        private readonly IIdGenerator _idGenerator;

        public NetlistRepositoryProvider(IIdGenerator idGenerator)
        {
            _idGenerator = idGenerator;
        }

        public INetlistRepository GetRepositoryFor(string netlist)
        {
            if (!Exists(netlist))
                _repos[netlist] = new NetlistRepository(_idGenerator);

            return _repos[netlist];
        }

        public void Dispose(string netlist)
        {
            _repos.Remove(netlist);
        }

        public bool Exists(string netlist)
        {
            return _repos.ContainsKey(netlist);
        }
    }
}