using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Windows;
using EdaTools.Model;
using EdaTools.Properties;
using EdaTools.Utility;
using EdaTools.View;
using Elicon.Console.Config;
using Elicon.Domain.GateLevel.Manipulations;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule;
using Elicon.Domain.GateLevel.Manipulations.UpperCaseNativeModulePorts;
using Elicon.Domain.GateLevel.Reports.CountNativeModules;
using Elicon.Domain.GateLevel.Reports.NativeModulesPortsList;
using Elicon.Domain.GateLevel.Reports.PhysicalModulePath;
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
        private bool CanExecute()
        {
            return _edaToolsModel.CanExecute();
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
            InitAmazingFramework();
            CreateUiCommands();
            LogWindowContents = $"{DateTime.Now}:  Session started.";
        }

        // =========================================
        // Model Properties Handler.
        // =========================================
        private void InitAmazingFramework()
        {
            //
            // TODO: Init the amazing EDA framework.
            //


            RefreshFrameworkData();
        }

        private void RefreshFrameworkData()
        {
            //
            // TODO: Fill items from the EDA framework.
            //
            _edaToolsModel.LoadedNetlists = new List<string> 
            {
                "netlist file 1", "netlist file 2", "netlist file 3", "netlist file 4"
            };
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
                LogWindowContents = LogWindowContents.AppendLine(String.Format("{0}:  Reading netlist... ({1})", DateTime.Now, value));
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
            FileMenuReadNetlist = new RelayCommand(param => OpenFileCommand());
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

        //private void worker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        //{
        //    //
        //    // TODO: Relay progress data to app main window.
        //    //
        //    // var pbar = new ProgressBar();
        //    // pbar.Value = e.ProgressPercentage;
        //}

        private void ListUndeclaredModulesCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.ListUndeclaredModules, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
                var report = Bootstrapper.Get<INativeModulesPortsListReport>();
                //                                                      , dataContext.TargetSaveFile
                report.GetNativeModulesPortsList(SourceFile(dataContext));
            }
        }

        private static string SourceFile(PromptDialogViewModel dataContext)
        {
            return dataContext.LoadedNetlists[dataContext.SelectedNetlistIndex];
        }

        private void CountPhysicalInstancesCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.CountPhysicalInstances, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
                var report = Bootstrapper.Get<ICountNativeModulesReport>();
                //                                                 dataContext.UserData1
                //                                                                      , dataContext.TargetSaveFile
                report.CountNativeModules(SourceFile(dataContext), dataContext.UserData1);
            }
        }

        private void ListModulePhysicalInstancesCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.ListPhysicalInstances, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
                var modules = CommaSeparatedStringToList(dataContext.UserData2);
                var report = Bootstrapper.Get<IPhysicalModulePathReport>();
                //                                                                              , dataContext.TargetSaveFile
                report.GetPhysicalPaths(SourceFile(dataContext), dataContext.UserData1, modules);
            }
        }

        private void ReplaceModuleCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.ReplaceModule, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
                var oldData = CommaSeparatedStringToList(dataContext.UserData1);
                var newData = CommaSeparatedStringToList(dataContext.UserData2);
                var replaceRequest = new ModuleReplaceRequest
                {
                    Netlist = SourceFile(dataContext),
                    NewNetlist = dataContext.TargetSaveFile,
                    ModuleToReplace = oldData[0],
                    NewModule = newData[0],
                    PortsMapping = MakePortMapping(oldData, newData)
                };

                var action = Bootstrapper.Get<INativeModuleReplaceManipulation>();
                action.Replace(replaceRequest);
            }
        }

        private List<string> CommaSeparatedStringToList(string listOfNames)
        {
            return listOfNames.Split(' ').Select(item => item.Trim()).Where(trimmedItem => trimmedItem.Length > 0).ToList();
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
                var bufferData = CommaSeparatedStringToList(dataContext.UserData1);
                RemoveBufferRequest removeBufferRequest = new RemoveBufferRequest
                {
                    Netlist = SourceFile(dataContext),
                    NewNetlist = dataContext.TargetSaveFile,
                    BufferName = bufferData[0],
                    InputPort = bufferData[1],
                    OutputPort = bufferData[2]
                };
                var action = Bootstrapper.Get<IRemoveBufferManipulation>();
                action.Remove(removeBufferRequest);
            }
        }

        private void UCasePortsCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.UCasePorts, LoadedNetlists);
            var dataContext = (PromptDialogViewModel)promptDialog.ShowModal();
            if (dataContext.DialogResult)
            {
                var action = Bootstrapper.Get<INativeModulePortsManipulation>();
                action.PortsToUpper(SourceFile(dataContext), dataContext.TargetSaveFile);
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
                //
                // TODO: 1) Ask the EDA framework to load the netlist.
                // TODO: 2) Request loaded-netlists from framework and update _edaToolsModel.LoadedNetlists
                //
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


    }
}