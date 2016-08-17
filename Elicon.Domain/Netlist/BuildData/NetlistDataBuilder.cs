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
        private readonly INetlistRepositoryProvider _netlistRepositoryProvider;

        public NetlistDataBuilder(INetlistFileReaderProvider netlistFileReaderProvider, IStatementHandlersInvoker statementHandlersInvoker, INetlistRepositoryProvider netlistRepositoryProvider)
        {
            _netlistFileReaderProvider = netlistFileReaderProvider;
            _statementHandlersInvoker = statementHandlersInvoker;
            _netlistRepositoryProvider = netlistRepositoryProvider;
        }

        public void Build(string source)
        {
            if (_netlistRepositoryProvider.Exists(source))
                return;

            var netlistFileReader = _netlistFileReaderProvider.GetReaderFor(source);
            var buildState = new BuildState { Netlist = source };

            while ((buildState.CurrentStatement = netlistFileReader.ReadStatement()) != null)
                _statementHandlersInvoker.Handle(buildState);
           
            UpdateInstancesType(source);
        }

        private void UpdateInstancesType(string source)
        {
            var netlistRepository = _netlistRepositoryProvider.GetRepositoryFor(source);

            foreach (var instance in netlistRepository.GetAllInstances())
            {
                if (!netlistRepository.Exists(instance.CellName))
                    continue;

                instance.Type = InstanceType.Module;
                netlistRepository.UpdateInstance(instance);
            }
        }
    }
}
