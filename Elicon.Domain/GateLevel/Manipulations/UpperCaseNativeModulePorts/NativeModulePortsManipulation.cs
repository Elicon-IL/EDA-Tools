using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.UpperCaseNativeModulePorts
{
    public interface INativeModulePortsManipulation
    {
        void PortsToUpper(string sourceNetlist, string newNetlist);
    }

    public class NativeModulePortsManipulation : INativeModulePortsManipulation
    {
        private readonly INetlistCloner _netlistCloner;
        private readonly INetlistFileWriter _netlistFileWriter;
        private readonly INativeModulePortsReplacer _nativeModulePortsReplacer;
        private readonly INetlistDataBuilder _netlistDataBuilder;

        public NativeModulePortsManipulation(INativeModulePortsReplacer nativeModulePortsReplacer, INetlistFileWriter netlistFileWriter, INetlistCloner netlistCloner, INetlistDataBuilder netlistDataBuilder)
        {
            _nativeModulePortsReplacer = nativeModulePortsReplacer;
            _netlistFileWriter = netlistFileWriter;
            _netlistCloner = netlistCloner;
            _netlistDataBuilder = netlistDataBuilder;
        }

        public void PortsToUpper(string sourceNetlist, string newNetlist)
        {
            _netlistDataBuilder.Build(sourceNetlist);
            _netlistCloner.Clone(sourceNetlist, newNetlist);

            _nativeModulePortsReplacer.PortsToUpper(newNetlist);

            _netlistFileWriter.Write(newNetlist, "Uppercase Native Module Ports");
        }
    }
}
