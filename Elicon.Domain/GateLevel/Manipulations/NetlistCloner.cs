using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface INetlistCloner
    {
        void Clone(string source, string newSource);
    }

    public class NetlistCloner : INetlistCloner
    {
        private readonly INetlistRepository _netlistRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceRepository _instanceRepository;

        public NetlistCloner(INetlistRepository netlistRepository, IModuleRepository moduleRepository, IInstanceRepository instanceRepository)
        {
            _netlistRepository = netlistRepository;
            _moduleRepository = moduleRepository;
            _instanceRepository = instanceRepository;
        }

        public void Clone(string source, string newSource)
        {
            var netlist = _netlistRepository.Get(source);
            netlist.Source = newSource;
            _netlistRepository.Add(netlist);

            foreach (var module in _moduleRepository.GetAll(source))
            {
                module.Netlist = newSource;
                _moduleRepository.Add(module);
            }

            foreach (var instance in _instanceRepository.GetBy(source))
            {
                instance.Netlist = newSource;
                _instanceRepository.Add(instance);
            }
        }
    }
}
