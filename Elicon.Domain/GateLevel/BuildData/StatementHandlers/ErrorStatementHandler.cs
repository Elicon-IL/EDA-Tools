using Elicon.Domain.GateLevel.Statements.Criterias;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class ErrorStatementHandler : IStatementHandler
    {
        private readonly ErrorStatementCriteria _criteria = new ErrorStatementCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}