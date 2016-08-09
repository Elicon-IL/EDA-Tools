using Elicon.Domain.Netlist.Commands.Criterias;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.Parse;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public class ModuleDeclarationCommandHandler : ICommandHandler
    {
        private readonly ModuleDeclarationCommandCriteria _criteria = new ModuleDeclarationCommandCriteria();
        private readonly ModuleDeclarationCommandParser _parser = new ModuleDeclarationCommandParser();
        private readonly IModuleRepository _moduleRepository;

        public ModuleDeclarationCommandHandler(IModuleRepository moduleRepository)
        {
            _moduleRepository = moduleRepository;
        }

        public void Handle(BuildState state)
        {
            state.CurrentModuleName = _parser.GetModuleName(state.CurrentCommand);
            _moduleRepository.Add(new Module(state.CurrentModuleName) { IsTop = state.CurrentModuleName == state.TopModuleName });
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentCommand);
        }
    }
}