using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public interface ICommandHandlersOrderer
    {
        IEnumerable<ICommandHandler> Order(IEnumerable<ICommandHandler> handlers);
    }

    public class CommandHandlersOrderer : ICommandHandlersOrderer
    {
        public IEnumerable<ICommandHandler> Order(IEnumerable<ICommandHandler> handlers)
        {
            ICommandHandler lastHandler = null;

            foreach (var handler in handlers)
            {
                if (handler is InstanceDeclarationCommandHandler)
                    lastHandler = handler;
                else
                    yield return handler;
            }

            yield return lastHandler;
        }
    }
}
