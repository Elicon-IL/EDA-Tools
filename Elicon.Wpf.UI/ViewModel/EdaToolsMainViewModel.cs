﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Windows;
using EdaTools.Model;
using EdaTools.Properties;
using EdaTools.Utility;
using EdaTools.View;
using Elicon.Domain.GateLevel.Manipulations;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule;
using Microsoft.Win32;

namespace EdaTools.ViewModel
{
    public sealed class EdaToolsMainViewModel : ViewModelBase
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

        private List<string> LoadedNetlists
        {
            get { return _edaToolsModel.LoadedNetlists; }
        }

        public EdaToolsMainViewModel()
        {
            var vi = new VersionInfo();
            DisplayName = $"{Resources.MainWindowViewModel_DisplayName} - {vi.Description}  Version {vi.Version}";
            _edaToolsModel = new EdaToolsModel();
            _toolRunner = new ToolRunner(TaskRunningFinished);
            InitAmazingFramework();
            CreateUiCommands();
            LogWindowContents = $"{DateTime.Now}:  Session started.";
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
                RaisePropertyChanged("NetlistReadFilePath");
                LogWindowContents = LogWindowContents.AppendLine($"{DateTime.Now}:  Reading netlist... ({value})");
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
                RaisePropertyChanged("LogWindowContents");
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
                OnPropertyChanged("ProgressBarValue");
            }
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

        private Window ParentWindow
        {
            get { return Application.Current.MainWindow; }
        }

        private void ListUndeclaredModulesCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.ListUndeclaredModules, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
                _toolRunner.GetNativeModulesPortsList(dataContext.SelectedNetlist, dataContext.TargetSaveFile);
            }
        }

        private void CountPhysicalInstancesCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.CountPhysicalInstances, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
                _toolRunner.CountPhysicalInstancesCommand(dataContext.SelectedNetlist, dataContext.UserData1, dataContext.TargetSaveFile);
            }
        }

        private void ListModulePhysicalInstancesCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.ListPhysicalInstances, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
                _toolRunner.ListModulePhysicalInstancesCommand(dataContext.SelectedNetlist, dataContext.UserData1, dataContext.UserData2, dataContext.TargetSaveFile);
            }
        }

        private void ReplaceModuleCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.ReplaceModule, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
                var oldData = dataContext.UserData1.CommaSeparatedStringToList();
                var newData = dataContext.UserData2.CommaSeparatedStringToList();
                var replaceRequest = new ModuleReplaceRequest
                {
                    Netlist = dataContext.SelectedNetlist,
                    NewNetlist = dataContext.TargetSaveFile,
                    ModuleToReplace = oldData[0],
                    NewModule = newData[0],
                    PortsMapping = MakePortMapping(oldData, newData)
                };

                _toolRunner.ReplaceModuleCommand(replaceRequest);
            }
        }

        private static PortsMapping MakePortMapping(List<string> oldModule, List<string> newModule)
        {
            var pm = new PortsMapping();
            for (int i = 1; i < oldModule.Count; i++)
                pm.AddMapping(oldModule[i], newModule[i]);
            return pm;
        }

        private void RemoveBuffersCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.RemoveBuffers, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
                var bufferData = dataContext.UserData1.CommaSeparatedStringToList();
                var removeBufferRequest = new RemoveBufferRequest
                {
                    Netlist = dataContext.SelectedNetlist,
                    NewNetlist = dataContext.TargetSaveFile,
                    BufferName = bufferData[0],
                    InputPort = bufferData[1],
                    OutputPort = bufferData[2]
                };
                _toolRunner.RemoveBuffersCommand(removeBufferRequest);
            }
        }

        private void UCasePortsCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.UCasePorts, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
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
                InitialDirectory = AppDomain.CurrentDomain.BaseDirectory
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

        //private void worker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        //{
        //    //
        //    // TODO: Relay progress data to app main window.
        //    //
        //    // var pbar = new ProgressBar();
        //    // pbar.Value = e.ProgressPercentage;
        //}

        private void TaskRunningFinished(object sender, ToolRunnerEventArgs e)
        {
            if (e.Error)
            {
                LogWindowContents = LogWindowContents.AppendLine($"{DateTime.Now}: ({e.ErrorMessage})");
            }
            RefreshFrameworkData(); 
        }

    }
}