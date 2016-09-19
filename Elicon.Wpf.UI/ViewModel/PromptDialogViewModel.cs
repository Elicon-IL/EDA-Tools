using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Windows;
using EdaTools.Model;
using EdaTools.Properties;
using EdaTools.Utility;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Elicon.Domain.GateLevel.Manipulations.ReplaceLibraryGate;
using Microsoft.Win32;

namespace EdaTools.ViewModel
{
    public class PromptDialogViewModel : ViewModelBase
    {
        private PromptDialogModel.Actions _currentUiAction;
        private readonly ExtendedObservableCollection<string> _loadedNetlists;
        private string _targetSaveAsFilter = "";
        private Visibility _firstPromptVisibility;
        private Visibility _secondPromptVisibility;
        private const string ReportSaveAsFilter = "Report files (*.rpt)|*.rpt|Text files (*.txt)|*.txt|All files (*.*)|*.*";
        private const string NetlistSaveAsFilter = "Verilog files (*.v)|*.v|Text files (*.txt)|*.txt|All files (*.*)|*.*";

        // ====================================================
        // ViewModel Properties.
        // ====================================================

        public PromptDialogModel PromptDialogModel { get; }

        public RelayCommand OkButtonCommand { get; }

        public RelayCommand TargetBrowseButtonCommand { get; }

        public RelayCommand NetlistBrowseButtonCommand { get; }


        public Action CloseAction { get; set; }

        public bool DialogResult { get; set; }

        public PromptDialogViewModel()
        {
            PromptDialogModel = new PromptDialogModel();
            OkButtonCommand = new RelayCommand(param => InvokeRequestClose(new RequestCloseEventArgs(true)), param => PromptDialogModel.CanExecute(CurrentUiAction));
            NetlistBrowseButtonCommand = new RelayCommand(param => OpenFileCommand());
            TargetBrowseButtonCommand = new RelayCommand(param => SaveAsCommand());
            _loadedNetlists = new ExtendedObservableCollection<string>();
        }

        // =========================================
        // Model Properties Handler.
        // =========================================

        public PromptDialogModel.Actions CurrentUiAction
        {
            get { return _currentUiAction; }
            set
            {
                if (_currentUiAction.Equals(value))
                    return;
                _currentUiAction = value;
                FirstPromptVisibility = Visibility.Visible;
                var doReport = false;
                switch (_currentUiAction)
                {
                    case PromptDialogModel.Actions.CountLibraryGatesInstances:
                        SecondPromptVisibility = Visibility.Collapsed;
                        DialogTitle = ViewTitle("Count Library Gates Instances");
                        UserPrompt1 = "Enter Starting (top) Module:";
                        Hint1 = "top_module_name";
                        doReport = true;
                        break;
                    case PromptDialogModel.Actions.ListPhysicalPaths:
                        SecondPromptVisibility = Visibility.Visible;
                        DialogTitle = ViewTitle("List Physical Paths");
                        UserPrompt1 = "Enter Starting (top) Module:";
                        Hint1 = @"top_module_name";
                        UserPrompt2 = "Enter name(s) of modules to list:";
                        Hint2 = "multiplex81 dspmod16";
                        doReport = true;
                        break;
                    case PromptDialogModel.Actions.ReplaceLibraryGate:
                        SecondPromptVisibility = Visibility.Visible;
                        DialogTitle = ViewTitle("Replace Library Gate");
                        UserPrompt1 = "Enter Module to Replace:";
                        Hint1 = "an3  i1 i2 i3 o";
                        UserPrompt2 = "Enter Replacing Module:";
                        Hint2 = "and3 in1 in2 in3 out"; 
                        break;
                    case PromptDialogModel.Actions.RemoveBuffers:
                        SecondPromptVisibility = Visibility.Collapsed;
                        DialogTitle = ViewTitle("Remove Buffers");
                        UserPrompt1 = "Enter Buffer Definition:";
                        Hint1 = "buffer_name  input_port  output_port";
                        break;
                    case PromptDialogModel.Actions.ListLibraryGates:
                        FirstPromptVisibility = Visibility.Collapsed;
                        SecondPromptVisibility = Visibility.Collapsed;
                        DialogTitle = ViewTitle("List Library Gates");
                        doReport = true;
                        break;
                    case PromptDialogModel.Actions.UpperCaseLibraryGatesPorts:
                        FirstPromptVisibility = Visibility.Collapsed;
                        SecondPromptVisibility = Visibility.Collapsed;
                        DialogTitle = ViewTitle("Upper Case Library Gates Ports");
                        break;
                }
                _targetSaveAsFilter = doReport ? ReportSaveAsFilter : NetlistSaveAsFilter;
            }
        }

        public string DialogTitle
        {
            get { return PromptDialogModel.DialogTitle; }
            set
            {
                PromptDialogModel.DialogTitle = value;
                RaisePropertyChanged();
            }
        }

        public string TargetSaveFile
        {
            get { return PromptDialogModel.TargetSaveFile; }
            set
            {
                PromptDialogModel.TargetSaveFile = value;
                RaisePropertyChanged();
            }
        }

        public Visibility FirstPromptVisibility
        {
            get { return _firstPromptVisibility; }
            private set
            {
                _firstPromptVisibility = value;
                RaisePropertyChanged();
            }
        }

        public Visibility SecondPromptVisibility
        {
            get { return _secondPromptVisibility; }
            private set
            {
                _secondPromptVisibility = value;
                RaisePropertyChanged();
            }
        }

        public ObservableCollection<string> LoadedNetlists
        {
            get { return _loadedNetlists; }
        }

        public void InitLoadedNetlists(List<string> netlists)
        {
            _loadedNetlists.Reload(netlists);
            SelectedNetlistIndex = _loadedNetlists.Count - 1;
        }

        public string SelectedNetlist
        {
            get { return _loadedNetlists.Count > 0 ? _loadedNetlists[SelectedNetlistIndex] : ""; }
        }

        public int SelectedNetlistIndex
        {
            get { return PromptDialogModel.SelectedNetlistIndex; }
            set
            {
                if (PromptDialogModel.SelectedNetlistIndex == value)
                    return;
                PromptDialogModel.SelectedNetlistIndex = value;
                PromptDialogModel.SelectedNetlist = SelectedNetlist;
                RaisePropertyChanged();
            }
        }

        public string UserData1
        {
            get { return PromptDialogModel.UserData1; }
            set
            {
                if (PromptDialogModel.UserData1 != null && PromptDialogModel.UserData1.Equals(value))
                    return;
                PromptDialogModel.UserData1 = value;
                RaisePropertyChanged();
            }
        }

        public string UserPrompt1
        {
            get { return PromptDialogModel.UserPrompt1; }
            set
            {
                if (PromptDialogModel.UserPrompt1 != null && PromptDialogModel.UserPrompt1.Equals(value))
                    return;
                PromptDialogModel.UserPrompt1 = value;
                RaisePropertyChanged();
            }
        }

        public string Hint1 { get; set; }

        public string UserData2
        {
            get { return PromptDialogModel.UserData2; }
            set
            {
                if (PromptDialogModel.UserData2 != null && PromptDialogModel.UserData2.Equals(value))
                    return;
                PromptDialogModel.UserData2 = value;
                RaisePropertyChanged();
            }
        }

        public string UserPrompt2
        {
            get { return PromptDialogModel.UserPrompt2; }
            set
            {
                if (PromptDialogModel.UserPrompt2 != null && PromptDialogModel.UserPrompt2.Equals(value))
                    return;
                PromptDialogModel.UserPrompt2 = value;
                RaisePropertyChanged();
            }
        }

        public string Hint2 { get; set; }

        private string ViewTitle(string uiCommand)
        {
            return $"{Resources.MainWindowViewModel_DisplayName} - {uiCommand} ";
        }

        // =========================================
        // ViewModel Commands Collection Handler.
        // =========================================

        private void InvokeRequestClose(RequestCloseEventArgs e)
        {
            if ((bool) e.ViewModelOutputData)
            {
                DialogResult = true;
            }
            CloseAction?.Invoke();
        }

        private void SaveAsCommand()
        {
            var saveFileDialog = new SaveFileDialog
            {
                Filter = _targetSaveAsFilter,
                InitialDirectory = AppDomain.CurrentDomain.BaseDirectory,
                FileName = Path.GetFileNameWithoutExtension(SelectedNetlist)
            };
            if (saveFileDialog.ShowDialog() == true)
            {
                TargetSaveFile = saveFileDialog.FileName;
            }
        }

        private void OpenFileCommand()
        {
            var openFileDialog = new OpenFileDialog
            {
                Filter = "Verilog files (*.v)|*.v|Text files (*.txt)|*.txt|All files (*.*)|*.*",
                InitialDirectory = AppDomain.CurrentDomain.BaseDirectory
            };
            if (openFileDialog.ShowDialog() == true)
            {
                LoadedNetlists.Add(openFileDialog.FileName);
                SelectedNetlistIndex = _loadedNetlists.Count - 1;
            }
        }

        // ====================================================
        // Model Utility Methods.
        // ====================================================

        public LibraryGateReplaceRequest MakeModuleReplaceRequest()
        {
            return PromptDialogModel.MakeModuleReplaceRequest();
        }

        public RemoveBufferRequest MakeRemoveBufferRequest()
        {
            return PromptDialogModel.MakeRemoveBufferRequest();
        }

        public string RootModule => PromptDialogModel.RootModule;

        public string ModuleNames =>PromptDialogModel.ModuleNames;

    }
}
