using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.Parse;
using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
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
            state.CurrentModuleName = _parser.GetModuleName(state.CurrentStatement);
            _moduleRepository
                 .AddModule(new Module(state.NetlistSource, state.CurrentModuleName));
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}