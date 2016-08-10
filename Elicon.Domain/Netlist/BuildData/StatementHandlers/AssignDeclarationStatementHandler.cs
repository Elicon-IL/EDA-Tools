using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public class AssignDeclarationStatementHandler : IStatementHandler
    {
        private readonly AssignDeclarationStatementCriteria _criteria = new AssignDeclarationStatementCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}