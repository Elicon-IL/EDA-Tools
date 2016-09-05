using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;
using Elicon.Console.Config;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule;
using Elicon.Domain.GateLevel.Manipulations.UpperCaseNativeModulePorts;
using Elicon.Domain.GateLevel.Reports.CountNativeModules;
using Elicon.Domain.GateLevel.Reports.NativeModulesPortsList;
using Elicon.Domain.GateLevel.Reports.PhysicalModulePath;

namespace EdaTools.Utility
{

    public class ToolRunnerEventArgs : EventArgs
    {
        public ToolRunnerEventArgs():this(false, "")
        {
            
        }

        public ToolRunnerEventArgs(bool error, string errorMessage)
        {
            Error = error;
            ErrorMessage = errorMessage;
        }

        public string ErrorMessage { get; set; }
        public bool Error { get; set; }
    }

    public class ToolRunner
    {
        public event EventHandler<ToolRunnerEventArgs> TaskRunningFinished;
        private ToolRunnerEventArgs _toolRunnerEventArgs;

        public ToolRunner(EventHandler<ToolRunnerEventArgs> taskRunningFinished)
        {
            TaskRunning = false;
            TaskRunningFinished += taskRunningFinished;
        }

        public bool TaskRunning { get; private set; }


        public async void GetNativeModulesPortsList(string netlist, string targetSaveFile)
        {
            InitRunner();
            var report = Bootstrapper.Get<INativeModulesPortsListReport>();
            //                                                           , targetSaveFile);    
            await Task.Run(() => report.GetNativeModulesPortsList(netlist));
            OnTaskRunningFinished(_toolRunnerEventArgs);
        }

        public async void CountPhysicalInstancesCommand(string netlist, string rootModule, string targetSaveFile)
        {
            InitRunner();
            var report = Bootstrapper.Get<ICountNativeModulesReport>();
            //                                           , targetSaveFile
            await Task.Run(() => report.CountNativeModules(netlist, rootModule));
            OnTaskRunningFinished(_toolRunnerEventArgs);
        }

        public async void ListModulePhysicalInstancesCommand(string netlist, string rootModule, string moduleNames, string targetSaveFile)
        {
            InitRunner();
            var modules = moduleNames.CommaSeparatedStringToList();
            var report = Bootstrapper.Get<IPhysicalModulePathReport>();
            //                                                                       , dataContext.TargetSaveFile
            await Task.Run(() => report.GetPhysicalPaths(netlist, rootModule, modules));
            OnTaskRunningFinished(_toolRunnerEventArgs);
        }

        public async void ReplaceModuleCommand(ModuleReplaceRequest replaceRequest)
        {
            InitRunner();
            var action = Bootstrapper.Get<INativeModuleReplaceManipulation>();
            await Task.Run(() => action.Replace(replaceRequest));
            OnTaskRunningFinished(_toolRunnerEventArgs);
        }

        public async void RemoveBuffersCommand(RemoveBufferRequest removeBufferRequest)
        {
            InitRunner();
            var action = Bootstrapper.Get<IRemoveBufferManipulation>();
            await Task.Run(() => action.Remove(removeBufferRequest));
            OnTaskRunningFinished(_toolRunnerEventArgs);
        }

        public async void UCasePortsCommand(string netlist, string targetSaveFile)
        {
            InitRunner();
            var action = Bootstrapper.Get<INativeModulePortsManipulation>();
            await Task.Run(() => action.PortsToUpper(netlist, targetSaveFile));
            OnTaskRunningFinished(_toolRunnerEventArgs);
        }

        public async void ReadNetlist(string netlistReadFilePath)
        {
            InitRunner();
            var action = Bootstrapper.Get<INetlistDataBuilder>();
            await Task.Run(() =>
            {
                try
                {
                    action.Build(netlistReadFilePath);
                }
                catch (Exception ex)
                {
                    _toolRunnerEventArgs.Error = true;
                    _toolRunnerEventArgs.ErrorMessage = ex.FormatMessage();
                }
            });
            // Debug.Print("Read Done");
            // string details = await ProcessItemAsync(20);
            OnTaskRunningFinished(_toolRunnerEventArgs);
        }

        //private async Task<string> ProcessItemAsync(int fakeDelay)
        //{
        //    for (var i = 1; i < fakeDelay; i++)
        //    {
        //        Thread.Sleep(50);
        //        Debug.Print(i.ToString());
        //    }
        //    return "RESULT";
        //}

        public IEnumerable<Netlist> GetNetlists()
        {
            var repository = Bootstrapper.Get<INetlistRepository>();
            return repository.GetAll();
        }

        private void InitRunner()
        {
            TaskRunning = true;
            _toolRunnerEventArgs = new ToolRunnerEventArgs(false, "test");
        }

        private void OnTaskRunningFinished(ToolRunnerEventArgs e)
        {
            TaskRunning = false;
            var handler = TaskRunningFinished;
            handler?.Invoke(this, e);
        }
    }
}
