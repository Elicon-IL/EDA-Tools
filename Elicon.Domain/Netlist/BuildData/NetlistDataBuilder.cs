using System.Linq;
using Elicon.Domain.Netlist.BuildData.CommandHandlers;
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
        private readonly IStatementHandler _statementHandler;
        private readonly BuildState _buildState = new BuildState();

        public NetlistDataBuilder(IInstanceRepository instanceRepository, IModuleRepository moduleRepository, INetlistReader netlistReader, IStatementHandler statementHandler)
        {
            _instanceRepository = instanceRepository;
            _moduleRepository = moduleRepository;
            _netlistReader = netlistReader;
            _statementHandler = statementHandler;
        }

        public void Build(string source)
        {
            _netlistReader.SetSource(source);
           
            while ((_buildState.CurrentCommand = _netlistReader.ReadCommand()) != null)
                _statementHandler.Handle(_buildState);
                
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
