using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Statements.Criterias;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class SupplyDeclarationStatementHandler : IStatementHandler
    {
        private readonly SupplyDeclarationStatementCriteria _criteria = new SupplyDeclarationStatementCriteria();
        private readonly IModuleRepository _moduleRepository;

        public SupplyDeclarationStatementHandler(IModuleRepository moduleRepository)
        {
            _moduleRepository = moduleRepository;
        }

        public void Handle(BuildState state)
        {
            var module = _moduleRepository.Get(state.NetlistSource, state.CurrentModuleName);
            module.SupplyDeclarations.Add(state.CurrentStatement);
            _moduleRepository.Update(module);
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}