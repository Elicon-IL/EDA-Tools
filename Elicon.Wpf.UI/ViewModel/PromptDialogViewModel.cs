using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Windows;
using EdaTools.Model;
using EdaTools.Properties;
using EdaTools.Utility;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule;
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
                    case PromptDialogModel.Actions.CountPhysicalInstances:
                        SecondPromptVisibility = Visibility.Collapsed;
                        DialogTitle = ViewTitle("Count Physical Instances");
                        UserPrompt1 = "Enter Starting (top) Module:";
                        doReport = true;
                        break;
                    case PromptDialogModel.Actions.ListPhysicalInstances:
                        SecondPromptVisibility = Visibility.Visible;
                        DialogTitle = ViewTitle("List Physical Instances");
                        UserPrompt1 = "Enter Starting (top) Module:";
                        UserPrompt2 = "Enter name(s) of modules to list:";
                        doReport = true;
                        break;
                    case PromptDialogModel.Actions.ReplaceModule:
                        SecondPromptVisibility = Visibility.Visible;
                        DialogTitle = ViewTitle("Replace Module");
                        UserPrompt1 = "Enter Module to Replace:";
                        UserPrompt2 = "Enter Replacing Module:";
                        break;
                    case PromptDialogModel.Actions.RemoveBuffers:
                        SecondPromptVisibility = Visibility.Collapsed;
                        DialogTitle = ViewTitle("Remove Buffers");
                        UserPrompt1 = "Enter Buffer Definition:";
                        UserData2 = "buf, in, out";
                        break;
                    case PromptDialogModel.Actions.ListUndeclaredModules:
                        FirstPromptVisibility = Visibility.Collapsed;
                        SecondPromptVisibility = Visibility.Collapsed;
                        DialogTitle = ViewTitle("List Undeclared Modules");
                        doReport = true;
                        break;
                    case PromptDialogModel.Actions.UCasePorts:
                        FirstPromptVisibility = Visibility.Collapsed;
                        SecondPromptVisibility = Visibility.Collapsed;
                        DialogTitle = ViewTitle("Upper Case Ports");
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

        private string ViewTitle(string uiCommand)
        {
            return String.Format("{0} - {1} ", Resources.MainWindowViewModel_DisplayName, uiCommand);
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

        public ModuleReplaceRequest MakeModuleReplaceRequest()
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
