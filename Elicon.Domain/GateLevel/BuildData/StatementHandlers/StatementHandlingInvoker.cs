using System.Linq;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public interface IStatementHandlersInvoker
    {
        void Handle(BuildState state);
    }

    public class StatementHandlersInvoker : IStatementHandlersInvoker
    {
        private readonly IStatementHandler[] _statementHandlers;

        public StatementHandlersInvoker(IStatementHandler[] statementHandlers, IStatementHandlersOrderer statementHandlersOrderer)
        {
            _statementHandlers = statementHandlers;
            _statementHandlers = statementHandlersOrderer.Order(statementHandlers).ToArray();
        }

        public void Handle(BuildState state)
        {
            _statementHandlers.First(h => h.CanHandle(state)).Handle(state);
        }
    }
}