using System.Linq;
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
        private readonly INetlistReader _netlistReader;
        private readonly IStatementHandlingInvoker _statementHandlingInvoker;
        private readonly BuildState _buildState = new BuildState();

        public NetlistDataBuilder(IInstanceRepository instanceRepository, IModuleRepository moduleRepository, INetlistReader netlistReader, IStatementHandlingInvoker statementHandlingInvoker)
        {
            _instanceRepository = instanceRepository;
            _moduleRepository = moduleRepository;
            _netlistReader = netlistReader;
            _statementHandlingInvoker = statementHandlingInvoker;
        }

        public void Build(string source)
        {
            _netlistReader.SetSource(source);
           
            while ((_buildState.CurrentStatement = _netlistReader.ReadStatement()) != null)
                _statementHandlingInvoker.Handle(_buildState);
                
            _netlistReader.Close();

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
