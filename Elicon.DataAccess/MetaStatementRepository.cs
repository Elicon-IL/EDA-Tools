using System.Collections.Generic;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class MetaStatementRepository : IMetaStatementRepository
    {
        private readonly List<string> _statements = new List<string>();

        public void Add(string metaStatement)
        {
            _statements.Add(metaStatement);
        }

        public IEnumerable<string> GetAll()
        {
            return _statements.ToArray();
        }

        public void Dispose()
        {
            _statements.Clear();
        }
    }
}