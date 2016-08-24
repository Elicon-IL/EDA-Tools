using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public interface IStatementHandlersOrderer
    {
        IEnumerable<IStatementHandler> Order(IEnumerable<IStatementHandler> handlers);
    }

    public class StatementHandlersOrderer : IStatementHandlersOrderer
    {
        public IEnumerable<IStatementHandler> Order(IEnumerable<IStatementHandler> handlers)
        {
            IStatementHandler lastHandler = null;

            foreach (var handler in handlers)
            {
                if (handler is InstanceDeclarationStatementHandler)
                    lastHandler = handler;
                else
                    yield return handler;
            }

            yield return lastHandler;
        }
    }
}
