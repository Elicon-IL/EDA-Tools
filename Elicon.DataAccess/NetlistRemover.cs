using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class NetlistRemover : INetlistRemover
    {
        private readonly INetlistRepository _netlistRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceRepository _instanceRepository;

        public NetlistRemover(INetlistRepository netlistRepository, IModuleRepository moduleRepository, IInstanceRepository instanceRepository)
        {
            _netlistRepository = netlistRepository;
            _moduleRepository = moduleRepository;
            _instanceRepository = instanceRepository;
        }

        public void Remove(string source)
        {
            if (!_netlistRepository.Exists(source))
                return;

            _netlistRepository.Remove(source);
            _moduleRepository.RemoveAll(source);
            _instanceRepository.RemoveAll(source);
        }
    }
}
