using Elicon.Domain.Netlist.Commands.Criterias;
using Elicon.Domain.Netlist.Parse;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public class DefineTopCommandHandler : ICommandHandler
    {
        private readonly DefineTopCommandCriteria _criteria = new DefineTopCommandCriteria();
        private readonly DefineTopCommandParser _parser = new DefineTopCommandParser();

        public void Handle(BuildState state)
        {
            state.TopModuleName = _parser.GetTopModuleName(state.CurrentCommand);
        }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentCommand);
        }
    }
}