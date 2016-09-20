using System;
using Elicon.Domain.GateLevel.BuildData.StatementHandlers;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.BuildData
{
    public interface INetlistDataBuilder
    {
        void Build(string source);
    }
    
    public class NetlistDataBuilder : INetlistDataBuilder
    {
        private readonly INetlistFileReaderProvider _netlistFileReaderProvider;
        private readonly IStatementHandlersInvoker _statementHandlersInvoker;
        private readonly IInstancesTypeUpdater _instancesTypeUpdater;
        private readonly INetlistRepository _netlistRepository;

        public NetlistDataBuilder(INetlistFileReaderProvider netlistFileReaderProvider, IStatementHandlersInvoker statementHandlersInvoker, IInstancesTypeUpdater instancesTypeUpdater, INetlistRepository netlistRepository)
        {
            _netlistFileReaderProvider = netlistFileReaderProvider;
            _statementHandlersInvoker = statementHandlersInvoker;
            _instancesTypeUpdater = instancesTypeUpdater;
            _netlistRepository = netlistRepository;
        }

        public void Build(string source)
        {
            if (_netlistRepository.Exists(source))
                return;

            var netlistFileReader = _netlistFileReaderProvider.GetReaderFor(source);
            var buildState = new BuildState { NetlistSource = source };

            try 
            {
                _netlistRepository.Add(new Netlist(source));
                while ((buildState.CurrentStatementTrimmed = netlistFileReader.ReadTrimmedStatement()) != null)
                    _statementHandlersInvoker.Handle(buildState);
            }
            catch (Exception e) { throw e; }
            finally { netlistFileReader.Close(); }

            _instancesTypeUpdater.UpdateInstancesType(source);
        }
    }
}
