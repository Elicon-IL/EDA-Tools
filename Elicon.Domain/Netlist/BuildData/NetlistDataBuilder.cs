using Elicon.Domain.Netlist.Commands;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.Parse;

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
        private readonly INetlistParser _netlistParser;
        
        private string _topModuleName;
        private string _currentModuleName;

        public NetlistDataBuilder(INetlistParser netlistParser, IInstanceRepository instanceRepository, IModuleRepository moduleRepository)
        {
            _netlistParser = netlistParser;
            _instanceRepository = instanceRepository;
            _moduleRepository = moduleRepository;
        }

        public void Build(string source)
        {
            _netlistParser.SetSource(source);

            while (_netlistParser.HasMoreCommands)
            {
                _netlistParser.Advance();

                switch (_netlistParser.CurrentCommandType)
                {
                    case CommandType.DefineTop:
                        _topModuleName = _netlistParser.GetTopModuleName();
                        break;
                    case CommandType.ModuleDeclaration:
                        _currentModuleName = _netlistParser.GetModuleName();
                        _moduleRepository.Add(new Module(_currentModuleName) { IsTop = _currentModuleName == _topModuleName });
                        break;
                    case CommandType.Instance:
                        var instance = new Instance(_netlistParser.GetCellName(), _netlistParser.GeInstanceName());
                        _instanceRepository.Add(instance, _currentModuleName);
                        break;
                    case CommandType.EndModule:
                        _currentModuleName = "";
                        break;
                    case CommandType.AssignDeclaration:
                    case CommandType.WireDeclaration:
                    case CommandType.PortDeclaration:
                    case CommandType.SupplyDeclaration:
                    case CommandType.Empty:
                        break;
                }
            }

            foreach (var instance in _instanceRepository.GetAll())
            {
                if (_moduleRepository.Get(instance.CellName) != null)
                {
                    instance.Type = InstanceType.Module;
                    _instanceRepository.Update(instance);
                }
            }
        }
    }
}
