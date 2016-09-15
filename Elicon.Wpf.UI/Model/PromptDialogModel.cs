using System.Collections.Generic;
using EdaTools.Utility;
using Elicon.Domain.GateLevel.Manipulations;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule;

namespace EdaTools.Model
{
    public class PromptDialogModel
    {

        public enum Actions
        {
            None,
            ListPhysicalPaths,
            CountLibraryGatesInstances,
            ListLibraryGates,
            UpperCaseLibraryGatesPorts,
            RemoveBuffers,
            ReplaceLibraryGate
        };

        public bool CanExecute(Actions currentUiAction)
        {
            if (SelectedNetlistIndex >= 0)
                if (!string.IsNullOrEmpty(TargetSaveFile))
                {
                    switch (currentUiAction)
                    {
                        case Actions.UpperCaseLibraryGatesPorts:
                        case Actions.ListLibraryGates:
                            return true;
                        case Actions.RemoveBuffers:
                        case Actions.CountLibraryGatesInstances:
                            return !string.IsNullOrEmpty(UserData1);
                        case Actions.ReplaceLibraryGate:
                        case Actions.ListPhysicalPaths:
                            if (!string.IsNullOrEmpty(UserData1))
                                if (!string.IsNullOrEmpty(UserData2))
                                    return true;
                            break;
                    }
                }
            return false;
        }

        // ====================================================
        // Model Properties.
        // ====================================================

        public PromptDialogModel()
        {
            SelectedNetlist = "";
        }

        public string DialogTitle { get; set; } = "";

        public string TargetSaveFile { get; set; } = "";

        public int SelectedNetlistIndex { get; set; } = -1;

        public string SelectedNetlist { get; set; }

        public string UserData1 { get; set; } = "";

        public string UserPrompt1 { get; set; } = "";

        public string UserData2 { get; set; } = "";

        public string UserPrompt2 { get; set; } = "";


        // ====================================================
        // Model Utility Methods.
        // ====================================================

        public string RootModule => UserData1;
        public string ModuleNames => UserData2;

        public ModuleReplaceRequest MakeModuleReplaceRequest()
        {
            var oldData = UserData1.CommaSeparatedStringToList();
            var newData = UserData2.CommaSeparatedStringToList();
            return new ModuleReplaceRequest
            {
                Netlist = SelectedNetlist,
                NewNetlist = TargetSaveFile,
                ModuleToReplace = oldData[0],
                NewModule = newData[0],
                PortsMapping = MakePortMapping(oldData, newData)
            };
        }

        public RemoveBufferRequest MakeRemoveBufferRequest()
        {
            var bufferData = UserData1.CommaSeparatedStringToList();
            return new RemoveBufferRequest
            {
                Netlist = SelectedNetlist,
                NewNetlist = TargetSaveFile,
                BufferName = bufferData[0],
                InputPort = bufferData[1],
                OutputPort = bufferData[2]
            };
        }

        private static PortsMapping MakePortMapping(List<string> oldModule, List<string> newModule)
        {
            var pm = new PortsMapping();
            for (int i = 1; i < oldModule.Count; i++)
                pm.AddMapping(oldModule[i], newModule[i]);
            return pm;
        }

    }
}
