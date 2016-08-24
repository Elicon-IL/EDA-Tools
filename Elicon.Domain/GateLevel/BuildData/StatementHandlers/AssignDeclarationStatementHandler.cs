using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Statements.Criterias;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class AssignDeclarationStatementHandler : IStatementHandler
    {
        private readonly AssignDeclarationStatementCriteria _criteria = new AssignDeclarationStatementCriteria();
        private readonly IModuleRepository _moduleRepository;

        public AssignDeclarationStatementHandler(IModuleRepository moduleRepository)
        {
            _moduleRepository = moduleRepository;
        }

        public void Handle(BuildState state)
        {
            var module = _moduleRepository.Get(state.NetlistSource, state.CurrentModuleName);
            module.AssignDeclarations.Add(state.CurrentStatement);
            _moduleRepository.Update(module);
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}