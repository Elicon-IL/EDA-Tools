using System;
using System.Collections.Generic;
using System.Windows;
using EdaTools.Model;
using EdaTools.Properties;
using EdaTools.Utility;
using Microsoft.Win32;

namespace EdaTools.ViewModel
{
    public class PromptDialogViewModel : ViewModelBase
    {
        private readonly RelayCommand _okButtonCommand;
        private readonly RelayCommand _browseButtonCommand;
        private readonly PromptDialogModel _promptDialogModel;
        private PromptDialogModel.Actions _currentUiAction;
        private readonly List<string> _loadedNetlists;
        private string _targetSaveAsFilter = "";
        private Visibility _firstPromptVisibility;
        private Visibility _secondPromptVisibility;
        private const string ReportSaveAsFilter = "Report files (*.rpt)|*.rpt|Text files (*.txt)|*.txt|All files (*.*)|*.*";
        private const string NetlistSaveAsFilter = "Verilog files (*.v)|*.v|Text files (*.txt)|*.txt|All files (*.*)|*.*";

        // ====================================================
        // ViewModel Properties.
        // ====================================================

        public PromptDialogModel PromptDialogModel
        {
            get { return _promptDialogModel; }
        }

        public RelayCommand OkButtonCommand
        {
            get { return _okButtonCommand; }
        }

        public RelayCommand BrowseButtonCommand
        {
            get { return _browseButtonCommand; }
        }

        public Action CloseAction { get; set; }

        public PromptDialogViewModel()
        {
            _promptDialogModel = new PromptDialogModel();
            _okButtonCommand = new RelayCommand(param => InvokeRequestClose(new RequestCloseEventArgs(true)), param => _promptDialogModel.CanExecute(CurrentUiAction));
            _browseButtonCommand = new RelayCommand(param => SaveAsCommand());
            _loadedNetlists = new List<string>();
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
            get { return _promptDialogModel.DialogTitle; }
            set
            {
                _promptDialogModel.DialogTitle = value;
                RaisePropertyChanged("DialogTitle");
            }
        }

        public string TargetSaveFile
        {
            get { return _promptDialogModel.TargetSaveFile; }
            set
            {
                _promptDialogModel.TargetSaveFile = value;
                RaisePropertyChanged("TargetSaveFile");
            }
        }

        public Visibility FirstPromptVisibility
        {
            get { return _firstPromptVisibility; }
            private set
            {
                _firstPromptVisibility = value;
                RaisePropertyChanged("FirstPromptVisibility");
            }
        }

        public Visibility SecondPromptVisibility
        {
            get { return _secondPromptVisibility; }
            private set
            {
                _secondPromptVisibility = value;
                RaisePropertyChanged("SecondPromptVisibility");
            }
        }

        public List<string> LoadedNetlists
        {
            get { return _loadedNetlists; }
            set
            {
                _loadedNetlists.Clear();
                _loadedNetlists.AddRange(value);
                RaisePropertyChanged("LoadedNetlists");
                if (_loadedNetlists.Count > 0)
                    SelectedNetlistIndex = 0;
            }
        }

        public int SelectedNetlistIndex
        {
            get { return _promptDialogModel.SelectedNetlistIndex; }
            set
            {
                if (_promptDialogModel.SelectedNetlistIndex == value)
                    return;
                _promptDialogModel.SelectedNetlistIndex = value;
                RaisePropertyChanged("SelectedNetlistIndex");
            }
        }

        public string UserData1
        {
            get { return _promptDialogModel.UserData1; }
            set
            {
                if (_promptDialogModel.UserData1 != null && _promptDialogModel.UserData1.Equals(value))
                    return;
                _promptDialogModel.UserData1 = value;
                RaisePropertyChanged("UserData1");
            }
        }

        public string UserPrompt1
        {
            get { return _promptDialogModel.UserPrompt1; }
            set
            {
                if (_promptDialogModel.UserPrompt1 != null && _promptDialogModel.UserPrompt1.Equals(value))
                    return;
                _promptDialogModel.UserPrompt1 = value;
                RaisePropertyChanged("UserPrompt1");
            }
        }

        public string UserData2
        {
            get { return _promptDialogModel.UserData2; }
            set
            {
                if (_promptDialogModel.UserData2 != null && _promptDialogModel.UserData2.Equals(value))
                    return;
                _promptDialogModel.UserData2 = value;
                RaisePropertyChanged("UserData2");
            }
        }

        public string UserPrompt2
        {
            get { return _promptDialogModel.UserPrompt2; }
            set
            {
                if (_promptDialogModel.UserPrompt2 != null && _promptDialogModel.UserPrompt2.Equals(value))
                    return;
                _promptDialogModel.UserPrompt2 = value;
                RaisePropertyChanged("UserPrompt2");
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
            ViewModelOutputData = e.ViewModelOutputData;
            if (CloseAction != null)
                CloseAction();
        }

        private void SaveAsCommand()
        {
            var saveFileDialog = new SaveFileDialog
            {
                Filter = _targetSaveAsFilter,
                InitialDirectory = AppDomain.CurrentDomain.BaseDirectory
            };
            if (saveFileDialog.ShowDialog() == true)
            {
                TargetSaveFile = saveFileDialog.FileName;
            }
        }
    }
}
