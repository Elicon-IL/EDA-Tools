using Elicon.Domain.Netlist.Commands.Criterias;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public class ErrorCommandHandler : ICommandHandler
    {
        private readonly ErrorCommandCriteria _criteria = new ErrorCommandCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentCommand);
        }
    }
}