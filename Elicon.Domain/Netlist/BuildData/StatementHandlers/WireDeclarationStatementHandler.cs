using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public class WireDeclarationStatementHandler : IStatementHandler
    {
        private readonly WireDeclarationStatementCriteria _criteria = new WireDeclarationStatementCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}