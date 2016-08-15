using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public class MetaStatementHandler : IStatementHandler
    {
        private readonly MetaStatementCriteria _criteria = new MetaStatementCriteria();
        private readonly IMetaStatementRepository _metaStatementRepository;

        public MetaStatementHandler(IMetaStatementRepository metaStatementRepository)
        {
            _metaStatementRepository = metaStatementRepository;
        }

        public void Handle(BuildState state)
        {
            _metaStatementRepository.Add(state.CurrentStatement);
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}