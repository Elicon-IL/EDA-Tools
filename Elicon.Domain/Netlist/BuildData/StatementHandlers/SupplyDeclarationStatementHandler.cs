using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
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
            var module = _moduleRepository.Get(state.Netlist, state.CurrentModuleName);
            module.SupplyDeclarations.Add(state.CurrentStatement);
            _moduleRepository.Update(module);
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}