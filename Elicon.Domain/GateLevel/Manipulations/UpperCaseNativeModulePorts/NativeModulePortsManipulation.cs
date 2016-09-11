using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;

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
        private readonly INetlistFileContentDirector _netlistFileContentDirector;
        
        public NativeModulePortsManipulation(INetlistCloner netlistCloner, IFileWriter fileWriter, INativeModulePortsReplacer nativeModulePortsReplacer, INetlistDataBuilder netlistDataBuilder, INetlistFileContentDirector netlistFileContentDirector)
        {
            _netlistCloner = netlistCloner;
            _fileWriter = fileWriter;
            _nativeModulePortsReplacer = nativeModulePortsReplacer;
            _netlistDataBuilder = netlistDataBuilder;
            _netlistFileContentDirector = netlistFileContentDirector;
        }

        public void PortsToUpper(string sourceNetlist, string newNetlist)
        {
            _netlistDataBuilder.Build(sourceNetlist);
            _netlistCloner.Clone(sourceNetlist, newNetlist);

            _nativeModulePortsReplacer.PortsToUpper(newNetlist);

            var content = _netlistFileContentDirector.Construct(newNetlist);
            _fileWriter.Write(newNetlist, "Uppercase Native Module Ports", content);
        }
    }
}
