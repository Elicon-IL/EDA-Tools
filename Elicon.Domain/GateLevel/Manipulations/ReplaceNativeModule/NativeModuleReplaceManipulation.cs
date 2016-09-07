using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule
{
    public interface INativeModuleReplaceManipulation
    {
        void Replace(ModuleReplaceRequest replaceRequest);
    }

    public class NativeModuleReplaceManipulation : INativeModuleReplaceManipulation
    {
        private readonly INetlistCloner _netlistCloner;
        private readonly INativeModuleReplacer _nativeModuleReplacer;
        private readonly IFileWriter _fileWriter;
        private readonly INetlistDataBuilder _netlistDataBuilder;

        public NativeModuleReplaceManipulation(INetlistCloner netlistCloner, INativeModuleReplacer nativeModuleReplacer, IFileWriter fileWriter, INetlistDataBuilder netlistDataBuilder)
        {
            _netlistCloner = netlistCloner;
            _nativeModuleReplacer = nativeModuleReplacer;
            _fileWriter = fileWriter;
            _netlistDataBuilder = netlistDataBuilder;
        }

        public void Replace(ModuleReplaceRequest replaceRequest)
        {
            _netlistDataBuilder.Build(replaceRequest.Netlist);
            _netlistCloner.Clone(replaceRequest.Netlist, replaceRequest.NewNetlist);

            _nativeModuleReplacer.Replace(replaceRequest.NewNetlist, replaceRequest.ModuleToReplace, replaceRequest.NewModule, replaceRequest.PortsMapping);

            _fileWriter.Write(new NetlistFileWriteRequest {
                Destination = replaceRequest.NewNetlist,
                Action = "Replace Native Modules"
            });
        }
    }
}
