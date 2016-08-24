using Elicon.Domain.Netlist.BuildData.StatementHandlers;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.Domain.Netlist.BuildData
{
    public interface INetlistDataBuilder
    {
        void Build(string source);
    }

    public class NetlistDataBuilder : INetlistDataBuilder
    {
        private readonly INetlistFileReaderProvider _netlistFileReaderProvider;
        private readonly IStatementHandlersInvoker _statementHandlersInvoker;
        private readonly IInstanceRepository _instanceRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly INetlistRepository _netlistRepository;

        public NetlistDataBuilder(INetlistFileReaderProvider netlistFileReaderProvider, IStatementHandlersInvoker statementHandlersInvoker, IInstanceRepository instanceRepository, IModuleRepository moduleRepository, INetlistRepository netlistRepository)
        {
            _netlistFileReaderProvider = netlistFileReaderProvider;
            _statementHandlersInvoker = statementHandlersInvoker;
            _instanceRepository = instanceRepository;
            _moduleRepository = moduleRepository;
            _netlistRepository = netlistRepository;
        }

        public void Build(string source)
        {
            if (_netlistRepository.Exists(source))
                return;

            _netlistRepository.Add(new Netlist(source));

            var netlistFileReader = _netlistFileReaderProvider.GetReaderFor(source);
            var buildState = new BuildState { NetlistSource = source };

            while ((buildState.CurrentStatement = netlistFileReader.ReadStatement()) != null)
                _statementHandlersInvoker.Handle(buildState);
           
            UpdateInstancesType(source);
        }

        private void UpdateInstancesType(string source)
        {
            foreach (var instance in _instanceRepository.GetBy(source))
            {
                if (!_moduleRepository.Exists(source, instance.ModuleName))
                    continue;

                instance.Type = InstanceType.Module;
                _instanceRepository.UpdateInstance(instance);
            }
        }
    }
}
