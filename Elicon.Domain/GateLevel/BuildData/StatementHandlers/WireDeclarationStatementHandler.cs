using Elicon.Domain.GateLevel.Statements.Criterias;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class WireDeclarationStatementHandler : IStatementHandler
    {
        private readonly WireDeclarationStatementCriteria _criteria = new WireDeclarationStatementCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatementTrimmed);
        }
    }
}
