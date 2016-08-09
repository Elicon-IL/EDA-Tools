using Elicon.Domain.Netlist.Commands.Criterias;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public class EmptyCommandHandler : ICommandHandler
    {
        private readonly EmptyCommandCriteria _criteria = new EmptyCommandCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentCommand);
        }
    }
}