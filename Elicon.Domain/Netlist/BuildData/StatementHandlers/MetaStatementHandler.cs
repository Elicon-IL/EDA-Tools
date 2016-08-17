using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public class MetaStatementHandler : IStatementHandler
    {
        private readonly MetaStatementCriteria _criteria = new MetaStatementCriteria();
        private readonly INetlistRepositoryProvider _netlistRepositoryProvider;

        public MetaStatementHandler(INetlistRepositoryProvider netlistRepositoryProvider)
        {
            _netlistRepositoryProvider = netlistRepositoryProvider;
        }
        
        public void Handle(BuildState state)
        {
            _netlistRepositoryProvider
                .GetRepositoryFor(state.Netlist)
                .AddMetaStatement(state.CurrentStatement);
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}