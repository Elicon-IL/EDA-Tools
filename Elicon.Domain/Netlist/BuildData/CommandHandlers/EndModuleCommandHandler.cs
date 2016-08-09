using Elicon.Domain.Netlist.Commands.Criterias;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public class EndModuleCommandHandler : ICommandHandler
    {
        private readonly EndModuleCommandCriteria _criteria = new EndModuleCommandCriteria();

        public void Handle(BuildState state)
        {
            state.CurrentModuleName = "";
        }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentCommand);
        }
    }
}