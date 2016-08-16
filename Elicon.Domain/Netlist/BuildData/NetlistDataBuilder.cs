using System.Linq;
using System.Linq.Expressions;
using Elicon.Domain.Netlist.BuildData.StatementHandlers;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.Read;

namespace Elicon.Domain.Netlist.BuildData
{
    public interface INetlistDataBuilder
    {
        void Build(string source);
    }

    public class NetlistDataBuilder : INetlistDataBuilder
    {
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceRepository _instanceRepository;
        private readonly INetlistReaderProvider _netlistReaderProvider;
        private readonly IStatementHandlingInvoker _statementHandlingInvoker;

        public NetlistDataBuilder(IModuleRepository moduleRepository, IInstanceRepository instanceRepository, INetlistReaderProvider netlistReaderProvider, IStatementHandlingInvoker statementHandlingInvoker)
        {
            _moduleRepository = moduleRepository;
            _instanceRepository = instanceRepository;
            _netlistReaderProvider = netlistReaderProvider;
            _statementHandlingInvoker = statementHandlingInvoker;
        }
        
        public void Build(string source)
        {
            var netListReader = _netlistReaderProvider.GetReaderFor(source);
            var buildState = new BuildState();

            while ((buildState.CurrentStatement = netListReader.ReadStatement()) != null)
                _statementHandlingInvoker.Handle(buildState);
           
            UpdateInstancesType();
        }

        private void UpdateInstancesType()
        {
            foreach (var instance in _instanceRepository.GetAll())
            {
                if (_moduleRepository.Get(instance.CellName) == null)
                    continue;

                instance.Type = InstanceType.Module;
                _instanceRepository.Update(instance);
            }
        }
    }
}
