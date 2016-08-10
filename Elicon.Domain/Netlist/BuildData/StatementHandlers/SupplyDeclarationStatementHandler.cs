using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public class SupplyDeclarationStatementHandler : IStatementHandler
    {
        private readonly SupplyDeclarationStatementCriteria _criteria = new SupplyDeclarationStatementCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}