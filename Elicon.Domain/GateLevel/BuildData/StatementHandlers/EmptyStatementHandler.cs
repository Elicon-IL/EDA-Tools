using Elicon.Domain.GateLevel.Statements.Criterias;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class EmptyStatementHandler : IStatementHandler
    {
        private readonly EmptyStatementCriteria _criteria = new EmptyStatementCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}