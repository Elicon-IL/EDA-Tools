using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class NetlistRepository : INetlistRepository
    {
        private readonly Dictionary<long, Netlist> _netlists = new Dictionary<long, Netlist>();
        private readonly IIdGenerator _idGenerator;

        public NetlistRepository(IIdGenerator idGenerator)
        {
            _idGenerator = idGenerator;
        }

        public void Add(Netlist netlist)
        {
            netlist.Id = _idGenerator.GenerateId();
            _netlists.Add(netlist.Id, new Netlist(netlist));
        }

        public Netlist Get(string source)
        {
            var result = _netlists.Values.Single(netlist => netlist.Source == source);

            return new Netlist(result);
        }

        public void Update(Netlist netlist)
        {
            _netlists[netlist.Id] = new Netlist(netlist);
        }

        public void Remove(string source)
        {
            var key = _netlists.Single(kvp => kvp.Value.Source == source).Key;
            _netlists.Remove(key);
        }

        public bool Exists(string source)
        {
            return _netlists.Values.Any(netlist => netlist.Source == source);
        }
    }
}