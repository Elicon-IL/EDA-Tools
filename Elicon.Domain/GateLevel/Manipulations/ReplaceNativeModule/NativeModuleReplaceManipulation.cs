using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;

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
        private readonly INetlistFileContentDirector _netlistFileContentDirector;

        public NativeModuleReplaceManipulation(INetlistCloner netlistCloner, INativeModuleReplacer nativeModuleReplacer, IFileWriter fileWriter, INetlistDataBuilder netlistDataBuilder, INetlistFileContentDirector netlistFileContentDirector)
        {
            _netlistCloner = netlistCloner;
            _nativeModuleReplacer = nativeModuleReplacer;
            _fileWriter = fileWriter;
            _netlistDataBuilder = netlistDataBuilder;
            _netlistFileContentDirector = netlistFileContentDirector;
        }

        public void Replace(ModuleReplaceRequest replaceRequest)
        {
            _netlistDataBuilder.Build(replaceRequest.Netlist);
            _netlistCloner.Clone(replaceRequest.Netlist, replaceRequest.NewNetlist);

            _nativeModuleReplacer.Replace(replaceRequest.NewNetlist, replaceRequest.ModuleToReplace, replaceRequest.NewModule, replaceRequest.PortsMapping);

            var content = _netlistFileContentDirector.Construct(replaceRequest.NewNetlist);
            _fileWriter.Write(replaceRequest.NewNetlist, "Replace Native Modules", content);
        }
    }
}
