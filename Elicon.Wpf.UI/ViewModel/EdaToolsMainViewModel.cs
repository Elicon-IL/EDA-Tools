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
    public class EdaToolsMainViewModel : ViewModelBase
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
            base.DisplayName = String.Format("{0} - {1}  Version {2}", Resources.MainWindowViewModel_DisplayName, vi.Description, vi.Version);
            _edaToolsModel = new EdaToolsModel();
            InitAmazingFramework();
            CreateUiCommands();
            LogWindowContents = String.Format("{0}:  Session started.", DateTime.Now);
        }

        // =========================================
        // Model Properties Handler.
        // =========================================
        private void InitAmazingFramework()
        {
            //
            // TODO: Init the amazing EDA framework.
            //
            Bootstrapper.Boot();




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
            ReportMenuListPhysicalInstances = new RelayCommand(param => ListPhysicalInstancesCommand(), param => CanExecute());
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
            var result = promptDialog.ShowModal();
            if (result is bool)
            {
                //
            }
            if (result.GetType().IsClass)
            {
                // 
                var report = Bootstrapper.Get<INativeModulesPortsListReport>();
                var orderedCells = report.GetNativeModulesPortsList("source");
            }
        }

        private void CountPhysicalInstancesCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.CountPhysicalInstances, LoadedNetlists);
            var result = promptDialog.ShowModal();
            if (result is bool)
            {
                //
            }
            if (result.GetType().IsClass)
            {
                // 
                var report = Bootstrapper.Get<ICountNativeModulesReport>();
                var orderedCells = report.CountNativeModules("source", "patgen_rtl");
            }
        }

        private void ListPhysicalInstancesCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.ListPhysicalInstances, LoadedNetlists);
            var result = promptDialog.ShowModal();
            if (result is bool)
            {
                //
            }
            if (result.GetType().IsClass)
            {
                var report = Bootstrapper.Get<IPhysicalModulePathReport>();
                var orderedCells = report.GetPhysicalPaths("source", "patgen_rtl", new List<string> { "module1", "module2" });
            }
        }

        private void ReplaceModuleCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.ReplaceModule, LoadedNetlists);
            var result = promptDialog.ShowModal();
            if (result is bool)
            {
                //
            }
            if (result.GetType().IsClass)
            {
                var action = Bootstrapper.Get<INativeModuleReplacer>();
                PortsMapping portsMapping  = new PortsMapping();
                action.Replace("source", "module_old", "module_new", portsMapping);
            }
        }

        private void RemoveBuffersCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.RemoveBuffers, LoadedNetlists);
            var result = promptDialog.ShowModal();
            if (result is bool)
            {
                //
            }
            if (result.GetType().IsClass)
            {
                var action = Bootstrapper.Get<IRemoveBufferManipulation>();
                RemoveBufferRequest removeBufferRequest = new RemoveBufferRequest();
                action.Remove(removeBufferRequest);
            }
        }

        private void UCasePortsCommand()
        {
            Window promptDialog = new PromptDialogView(ParentWindow, PromptDialogModel.Actions.UCasePorts, LoadedNetlists);
            var result = promptDialog.ShowModal();
            if (result is bool)
            {
                //
            }
            if (result.GetType().IsClass)
            {
                var action = Bootstrapper.Get<INativeModulePortsReplacer>();
                action.PortsToUpper("source");
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