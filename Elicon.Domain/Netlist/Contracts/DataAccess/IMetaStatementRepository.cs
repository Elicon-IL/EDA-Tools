using System.Collections.Generic;

namespace Elicon.Domain.Netlist.Contracts.DataAccess
{
    public interface IMetaStatementRepository
    {
        void AddMetaStatement(string netlist, string metaStatement);
        IEnumerable<string> GeeMetaStatements(string netlist);
    }
}