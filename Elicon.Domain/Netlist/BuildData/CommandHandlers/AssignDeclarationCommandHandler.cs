using Elicon.Domain.Netlist.Commands.Criterias;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public class AssignDeclarationCommandHandler : ICommandHandler
    {
        private readonly AssignDeclarationCommandCriteria _criteria = new AssignDeclarationCommandCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentCommand);
        }
    }
}