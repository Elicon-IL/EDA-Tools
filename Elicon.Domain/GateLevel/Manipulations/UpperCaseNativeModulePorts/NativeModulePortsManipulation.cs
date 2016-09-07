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
        private readonly IFileWriter _fileWriter;
        private readonly INativeModulePortsReplacer _nativeModulePortsReplacer;
        private readonly INetlistDataBuilder _netlistDataBuilder;

        public NativeModulePortsManipulation(INetlistCloner netlistCloner, IFileWriter fileWriter, INativeModulePortsReplacer nativeModulePortsReplacer, INetlistDataBuilder netlistDataBuilder)
        {
            _netlistCloner = netlistCloner;
            _fileWriter = fileWriter;
            _nativeModulePortsReplacer = nativeModulePortsReplacer;
            _netlistDataBuilder = netlistDataBuilder;
        }

        public void PortsToUpper(string sourceNetlist, string newNetlist)
        {
            _netlistDataBuilder.Build(sourceNetlist);
            _netlistCloner.Clone(sourceNetlist, newNetlist);

            _nativeModulePortsReplacer.PortsToUpper(newNetlist);

            _fileWriter.Write(new NetlistFileWriteRequest {
                Destination = newNetlist,
                Action = "Uppercase Native Module Ports"
            });

        }
    }
}
