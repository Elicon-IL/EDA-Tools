using System.Collections.Generic;

namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface IMetaStatementRepository
    {
        void Add(string metaStatement);
        IEnumerable<string> GetAll();
    }
}