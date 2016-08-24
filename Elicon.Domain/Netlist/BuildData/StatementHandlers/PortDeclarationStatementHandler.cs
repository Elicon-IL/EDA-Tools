using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public class PortDeclarationStatementHandler : IStatementHandler
    {
        private readonly PortDeclarationStatementCriteria _criteria = new PortDeclarationStatementCriteria();
        private readonly IModuleRepository _moduleRepository;

        public PortDeclarationStatementHandler(IModuleRepository moduleRepository)
        {
            _moduleRepository = moduleRepository;
        }

        public void Handle(BuildState state)
        {
            var module = _moduleRepository.Get(state.Netlist, state.CurrentModuleName);
            module.PortDeclarations.Add(state.CurrentStatement);
            _moduleRepository.Update(module);
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}