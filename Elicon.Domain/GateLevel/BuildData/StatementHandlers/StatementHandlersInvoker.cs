using System.Linq;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public interface IStatementHandlersInvoker
    {
        void Handle(BuildState state);
    }

    public class StatementHandlersInvoker : IStatementHandlersInvoker
    {
        private readonly IStatementHandler[] _orderedHandlers;

        public StatementHandlersInvoker(IStatementHandler[] statementHandlers, IStatementHandlersOrderer statementHandlersOrderer)
        {
           _orderedHandlers = statementHandlersOrderer.Order(statementHandlers).ToArray();
        }

        public void Handle(BuildState state)
        {
            _orderedHandlers.First(h => h.CanHandle(state)).Handle(state);
        }
    }
}