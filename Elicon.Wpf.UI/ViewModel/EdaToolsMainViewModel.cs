using System;
using System.Collections.Generic;
using System.IO;
using System.Windows;
using EdaTools.Model;
using EdaTools.Properties;
using EdaTools.Utility;
using EdaTools.View;
using Elicon.Domain.GateLevel.Read;
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

        public RelayCommand UtilityMenuUCasePorts { get; private set; }
        public RelayCommand UtilityMenuRemoveBuffers { get; private set; }
        public RelayCommand UtilityMenuReplaceModule { get; private set; }

        public RelayCommand ReportMenuListPhysicalInstances { get; private set; }
        public RelayCommand ReportMenuCountPhysicalInstances { get; private set; }
        public RelayCommand ReportMenuListUndeclaredModules { get; private set; }

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
            var vi = new VersionInfo();
            DisplayName = $"{Resources.MainWindowViewModel_DisplayName} - {vi.Description}  Version {vi.Version}";
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
            UtilityMenuUCasePorts = new RelayCommand(param => UCasePortsCommand(), param => CanExecute());
            UtilityMenuRemoveBuffers = new RelayCommand(param => RemoveBuffersCommand(), param => CanExecute());
            UtilityMenuReplaceModule = new RelayCommand(param => ReplaceModuleCommand(), param => CanExecute());
            // =====================================================================
            ReportMenuListPhysicalInstances = new RelayCommand(param => ListModulePhysicalInstancesCommand(), param => CanExecute());
            ReportMenuCountPhysicalInstances = new RelayCommand(param => CountPhysicalInstancesCommand(), param => CanExecute());
            ReportMenuListUndeclaredModules = new RelayCommand(param => ListUndeclaredModulesCommand(), param => CanExecute());
        }

        private PromptDialogViewModel GetPromptDialogData(PromptDialogModel.Actions action)
        {
            Window promptDialog = new PromptDialogView(ParentWindow, action, LoadedNetlists);
            return (PromptDialogViewModel)promptDialog.ShowModal();
        }
        private void ListUndeclaredModulesCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.ListUndeclaredModules);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("list undeclared modules tool", dataContext);
                _toolRunner.GetNativeModulesPortsList(dataContext.SelectedNetlist, dataContext.TargetSaveFile);
            }
        }

        private void CountPhysicalInstancesCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.CountPhysicalInstances);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("count physical instances tool", dataContext);
                _toolRunner.CountPhysicalInstancesCommand(dataContext.SelectedNetlist, dataContext.RootModule, dataContext.TargetSaveFile);
            }
        }

        private void ListModulePhysicalInstancesCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.ListPhysicalInstances);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("list module physical instances tool", dataContext);
                _toolRunner.ListModulePhysicalInstancesCommand(dataContext.SelectedNetlist, dataContext.RootModule, dataContext.ModuleNames, dataContext.TargetSaveFile);
            }
        }

        private void ReplaceModuleCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.ReplaceModule);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("replace module tool", dataContext);
                var replaceRequest = dataContext.MakeModuleReplaceRequest();
                _toolRunner.ReplaceModuleCommand(replaceRequest);
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

        private void UCasePortsCommand()
        {
            var dataContext = GetPromptDialogData(PromptDialogModel.Actions.UCasePorts);
            if (dataContext.DialogResult)
            {
                LogNowRunningTool("upper-case native module ports tool", dataContext);
                _toolRunner.UCasePortsCommand(dataContext.SelectedNetlist, dataContext.TargetSaveFile);
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