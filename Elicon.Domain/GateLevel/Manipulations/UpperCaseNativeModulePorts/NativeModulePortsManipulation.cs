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

        public NativeModulePortsManipulation(INativeModulePortsReplacer nativeModulePortsReplacer, INetlistFileWriter netlistFileWriter, INetlistCloner netlistCloner)
        {
            _nativeModulePortsReplacer = nativeModulePortsReplacer;
            _netlistFileWriter = netlistFileWriter;
            _netlistCloner = netlistCloner;
        }

        public void PortsToUpper(string sourceNetlist, string newNetlist)
        {
            _netlistCloner.Clone(sourceNetlist, newNetlist);

            _nativeModulePortsReplacer.PortsToUpper(newNetlist);

            _netlistFileWriter.Write(newNetlist);
        }
    }
}
