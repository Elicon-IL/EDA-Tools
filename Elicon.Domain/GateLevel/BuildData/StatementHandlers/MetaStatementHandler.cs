using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Statements.Criterias;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class MetaStatementHandler : IStatementHandler
    {
        private readonly MetaStatementCriteria _criteria = new MetaStatementCriteria();
        private readonly INetlistRepository _netlistRepository;

        public MetaStatementHandler(INetlistRepository netlistRepository)
        {
            _netlistRepository = netlistRepository;
        }


        public void Handle(BuildState state)
        {
           var netlist = _netlistRepository.Get(state.NetlistSource);

            netlist.MetaStatements.Add(state.CurrentStatement);
           _netlistRepository.Update(netlist);
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}