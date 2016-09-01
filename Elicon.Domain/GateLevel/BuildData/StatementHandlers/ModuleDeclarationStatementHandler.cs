using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Parse;
using Elicon.Domain.GateLevel.Statements.Criterias;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class ModuleDeclarationStatementHandler : IStatementHandler
    {
        private readonly ModuleDeclarationStatementCriteria _criteria = new ModuleDeclarationStatementCriteria();
        private readonly ModuleDeclarationStatementParser _parser = new ModuleDeclarationStatementParser();
        private readonly IModuleRepository _moduleRepository;

        public ModuleDeclarationStatementHandler(IModuleRepository moduleRepository)
        {
            _moduleRepository = moduleRepository;
        }

        public void Handle(BuildState state)
        {
            state.CurrentModuleName = _parser.GetModuleName(state.CurrentStatementTrimmed);
            var module = new Module(state.NetlistSource, state.CurrentModuleName) {
                Ports = _parser.GetPorts(state.CurrentStatementTrimmed)
            };

            _moduleRepository.Add(module);
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatementTrimmed);
        }
    }
}