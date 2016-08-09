using Elicon.Domain.Netlist.Commands.Criterias;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public class SupplyDeclarationCommandHandler : ICommandHandler
    {
        private readonly SupplyDeclarationCommandCriteria _criteria = new SupplyDeclarationCommandCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentCommand);
        }
    }
}