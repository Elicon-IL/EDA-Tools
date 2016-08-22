using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Framework;

namespace Elicon.DataAccess
{
    public class MetaStatementRepository : IMetaStatementRepository
    {
        private readonly Dictionary<string, List<string>> _netlistsMetaStatementsMap = new Dictionary<string, List<string>>();

        public void AddMetaStatement(string netlist, string metaStatement)
        {
            _netlistsMetaStatementsMap.ValueOrNew(netlist).Add(metaStatement);
        }

        public IEnumerable<string> GeeMetaStatements(string netlist)
        {
            return _netlistsMetaStatementsMap.ValueOrNew(netlist).ToList();
        }
    }
}