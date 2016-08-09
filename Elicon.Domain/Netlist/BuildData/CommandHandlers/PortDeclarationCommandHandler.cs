using Elicon.Domain.Netlist.Commands.Criterias;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public class PortDeclarationCommandHandler : ICommandHandler
    {
        private readonly PortDeclarationCommandCriteria _criteria = new PortDeclarationCommandCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentCommand);
        }
    }
}