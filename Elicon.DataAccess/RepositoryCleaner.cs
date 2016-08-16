using Elicon.Domain;
using Elicon.Domain.Netlist.BuildData;

namespace Elicon.DataAccess
{
    public interface IEventSubscriber
    {
        void Init();
    }

    public class CleanDataEventSubscriber : IEventSubscriber
    {
        private readonly IPubSub _pubSub;
        private readonly IRepository[] _repositories;

        public CleanDataEventSubscriber(IPubSub pubSub, IRepository[] repositories)
        {
            _pubSub = pubSub;
            _repositories = repositories;
        }

        public void Init()
        {
            _pubSub.Subscribe<BuildNetlistStartedEvent>(e => {
                foreach (var repository in _repositories)
                    repository.Dispose();                            
            });
        }
    }

    
}
