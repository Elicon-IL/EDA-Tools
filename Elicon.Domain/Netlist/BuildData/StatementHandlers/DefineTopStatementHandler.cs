using Elicon.Domain.Netlist.Parse;
using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public class DefineTopStatementHandler : IStatementHandler
    {
        private readonly DefineTopStatementCriteria _criteria = new DefineTopStatementCriteria();
        private readonly DefineTopStatementParser _parser = new DefineTopStatementParser();

        public void Handle(BuildState state)
        {
            state.TopModuleName = _parser.GetTopModuleName(state.CurrentStatement);
        }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}