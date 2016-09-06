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
        private readonly INetlistFileWriter _netlistFileWriter;

        public NativeModuleReplaceManipulation(INetlistCloner netlistCloner, INativeModuleReplacer nativeModuleReplacer, INetlistFileWriter netlistFileWriter)
        {
            _netlistCloner = netlistCloner;
            _nativeModuleReplacer = nativeModuleReplacer;
            _netlistFileWriter = netlistFileWriter;
        }

        public void Replace(ModuleReplaceRequest replaceRequest)
        {
            _netlistCloner.Clone(replaceRequest.Netlist, replaceRequest.NewNetlist);

            _nativeModuleReplacer.Replace(replaceRequest.NewNetlist, replaceRequest.ModuleToReplace, replaceRequest.NewModule, replaceRequest.PortsMapping);

            _netlistFileWriter.Write(replaceRequest.NewNetlist, "Replace Native Modules");
        }
    }
}
