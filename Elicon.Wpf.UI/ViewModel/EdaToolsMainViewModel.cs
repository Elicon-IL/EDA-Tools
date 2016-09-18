using System;
using System.Collections.Generic;
using System.IO;
using System.Windows;
using EdaTools.Model;
using EdaTools.Properties;
using EdaTools.Utility;
using EdaTools.View;
using Elicon.Config;
using Elicon.Domain;
using Elicon.Domain.GateLevel.Read;
using Elicon.Domain.GateLevel.Reports.ListLibraryGates;
using Microsoft.Win32;

namespace EdaTools.ViewModel
{
    public interface IEdaToolsMainViewModel
    {
        void UpdateProgress(int value);
        void CreateAppCloseCommand(EdaToolsMainView appMainWindow);
    }

    public sealed class EdaToolsMainViewModel : ViewModelBase, IEdaToolsMainViewModel
    {

        // ====================================================
        // ViewModel Properties.
        // ====================================================

        public RelayCommand FileMenuReadNetlist { get; private set; }
        public RelayCommand FileMenuCopyLog { get; private set; }
        public RelayCommand FileMenuSaveLog { get; private set; }
        public RelayCommand FileMenuAbout { get; private set; }

        public RelayCommand UtilityMenuUpperCaseLibraryGatesPorts { get; private set; }
        public RelayCommand UtilityMenuRemoveBuffers { get; private set; }
        public RelayCommand UtilityMenuReplaceLibraryGate { get; private set; }

        public RelayCommand ReportMenuListPhysicalPaths { get; private set; }
        public RelayCommand ReportMenuCountLibraryGatesInstances { get; private set; }
        public RelayCommand ReportMenuListLibraryGates { get; private set; }

        private readonly EdaToolsModel _edaToolsModel;
        private readonly ToolRunner _toolRunner;


        private bool CanExecute()
        {
            return _toolRunner.TaskRunning == false;
        }

        private List<string> LoadedNetlists => _edaToolsModel.LoadedNetlists;
        private static Window ParentWindow => Application.Current.MainWindow;


        public EdaToolsMainViewModel()
        {
            var vi = Bootstrapper.Get<IApplicationInfo>();
            DisplayName = $"{vi.AppName} - {vi.AppDescription}, Version {vi.AppVersion()} by {vi.CompanyName}";
            _edaToolsModel = new EdaToolsModel();
            _toolRunner = new ToolRunner(TaskRunningFinished);
            InitAmazingFramework();
            CreateUiCommands();
            LogWindowContents = $"{DateTime.Now}: Session started.";
            // Create the progress updating delegate.
            ProgressUpdater = result =>
            {
                UpdateProgress(result.Progress);
            };
        }

        public Action<FileReadProgressEvent> ProgressUpdater;

        public void UpdateProgress(int value)
        {
            ProgressBarValue = value;
        }

        // =========================================
        // Model Properties Handler.
        // =========================================
        private void InitAmazingFramework()
        {
            RefreshFrameworkData();
        }

        private void RefreshFrameworkData()
        {
            LoadedNetlists.Clear();
            foreach (var netlist in _toolRunner.GetNetlists())
            {
                _edaToolsModel.LoadedNetlists.Add(netlist.Source);
            }
            
        }

        public string NetlistReadFilePath
        {
            get { return _edaToolsModel.NetlistReadFilePath; }
            set
            {
                if (_edaToolsModel.NetlistReadFilePath != null && _edaToolsModel.NetlistReadFilePath.Equals(value))
                    return;
                _edaToolsModel.NetlistReadFilePath = value;
                RaisePropertyChanged();
            }
        }

        public string LogWindowContents
        {
            get { return _edaToolsModel.LogWindowContents; }
            set
            {
                if (_edaToolsModel.LogWindowContents != null && _edaToolsModel.LogWindowContents.Equals(value))
                    return;
                _edaToolsModel.LogWindowContents = value;
                RaisePropertyChanged();
            }
        }

        public int ProgressBarValue
        {
            get { return _edaToolsModel.ProgressBarValue; }
            set
            {
                if (value == _edaToolsModel.ProgressBarValue)
                    return;
                _edaToolsModel.ProgressBarValue = value;
                RaisePropertyChanged();
            }
        }

        public Visibility ProgressBarVisibility
        {
            get { return _edaToolsModel.ProgressBarVisibility; }
            set
            {
                if (value == _edaToolsModel.ProgressBarVisibility)
                    return;
                _edaToolsModel.ProgressBarVisibility = value;
                RaisePropertyChanged();
            }
        }

        public void CreateAppCloseCommand(EdaToolsMainView appMainWindow)
        {
            this.CreateViewCloseCommand(appMainWindow);
        }


        // =========================================
        // ViewModel Commands Collection Handler.
        // =========================================

        private void CreateUiCommands()
        {
            FileMenuReadNetlist = new RelayCommand(param => OpenFileCommand(), param => CanExecute());
            FileMenuCopyLog = new RelayCommand(param => CopyLogCommand());
            FileMenuSaveLog = new RelayCommand(param => SaveLogCommand());
            FileMenuAbout = new RelayCommand(param => AboutCommand());
            // =====================================================================
            UtilityMenuUpperCaseLibraryGatesPorts = new RelayCommand(param => UpperCaseLibraryGatesPortsCommand(), param => CanExecute());
            UtilityMenuRemoveBuffers = new RelayCommand(param => RemoveBuffersCommand(), param => CanExecute());
            UtilityMenuReplaceLibraryGate = new RelayCommand(param => ReplaceLibraryGateCommand(), param => CanExecute());
            // =====================================================================
            ReportMenuListPhysicalPaths = new RelayCommand(param => ListPhysicalPathsCommand(), param => CanExecute());
            ReportMenuCountLibraryGatesInstances = new RelayCommand(param => CountLibraryGatesInstancesCommand(), param => CanExecute());
            ReportMenuListLibraryGates = new RelayCommand(param => ListLibraryGatesCommand(), param => CanExecute());
        }

        private PromptDialogViewModel GetPromptDialogData(PromptDialogModel.Actions action)
        {
            Window promptDialog = new PromptDialogView(ParentWindow, action, LoadedNetlists);
            return (PromptDialogViewModel)promptDialog.ShowModal();
        }
        private void ListLibraryGatesCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.ListLibraryGates);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("list library gates tool", dataContext);
                _toolRunner.ListLibraryGates(dataContext.SelectedNetlist, dataContext.TargetSaveFile);
            }
        }

        private void CountLibraryGatesInstancesCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.CountLibraryGatesInstances);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("count library gates physical instances tool", dataContext);
                _toolRunner.CountLibraryGatesInstancesCommand(dataContext.SelectedNetlist, dataContext.RootModule, dataContext.TargetSaveFile);
            }
        }

        private void ListPhysicalPathsCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.ListPhysicalPaths);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("list physical paths tool", dataContext);
                _toolRunner.ListPhysicalPathsCommand(dataContext.SelectedNetlist, dataContext.RootModule, dataContext.ModuleNames, dataContext.TargetSaveFile);
            }
        }

        private void ReplaceLibraryGateCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.ReplaceLibraryGate);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("replace library gate instances tool", dataContext);
                var replaceRequest = dataContext.MakeModuleReplaceRequest();
                _toolRunner.ReplaceLibraryGateCommand(replaceRequest);
            }
        }

        private void RemoveBuffersCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.RemoveBuffers);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("remove buffers tool", dataContext);
                var removeBufferRequest = dataContext.MakeRemoveBufferRequest();
                _toolRunner.RemoveBuffersCommand(removeBufferRequest);
            }
        }

        private void UpperCaseLibraryGatesPortsCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.UpperCaseLibraryGatesPorts);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("upper-case library gates ports tool", dataContext);
                _toolRunner.UpperCaseLibraryGatesPortsCommand(dataContext.SelectedNetlist, dataContext.TargetSaveFile);
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
                NetlistReadFilePath = openFileDialog.FileName;
                LogWindowContents = LogWindowContents.AppendLine($"{DateTime.Now}: Reading netlist... ({NetlistReadFilePath})");
                ProgressBarVisibility = Visibility.Visible;
                _toolRunner.ReadNetlist(NetlistReadFilePath);
            }
        }

        private void AboutCommand()
        {
            Window aboutDlg = new AboutEdaToolsView(ParentWindow);
            aboutDlg.ShowDialog();
        }

        private void SaveLogCommand()
        {
            var saveFileDialog = new SaveFileDialog
            {
                Filter = "Log file (*.log)|*.log|Text file (*.txt)|*.txt",
                InitialDirectory = AppDomain.CurrentDomain.BaseDirectory,
                FileName = $"EdaTools_Session_Log_{DateTime.Now.ToString("dd_MM_yyyy")}"
            };
            if (saveFileDialog.ShowDialog() == true)
            {
                File.WriteAllText(saveFileDialog.FileName, LogWindowContents);
            }
        }

        private void CopyLogCommand()
        {
            Clipboard.SetText(LogWindowContents);
        }

        // ====================================================
        // ViewModel Event Handlers.
        // ====================================================

        private void TaskRunningFinished(object sender, ToolRunnerEventArgs e)
        {
            var message = e.Error ? e.ErrorMessage : "Done.";
            LogWindowContents = LogWindowContents.AppendLine($"{DateTime.Now}: {message}");
            ProgressBarValue = 0;
            ProgressBarVisibility = Visibility.Hidden;
            RefreshFrameworkData(); 
        }

        private void LogNowRunningTool(string tool, PromptDialogViewModel dataContext)
        {
            ProgressBarVisibility = Visibility.Visible;
            LogWindowContents = LogWindowContents.AppendLine($"{DateTime.Now}: Running {tool} (netlist = {Path.GetFileName(dataContext.SelectedNetlist)}).");
        }

    }

}