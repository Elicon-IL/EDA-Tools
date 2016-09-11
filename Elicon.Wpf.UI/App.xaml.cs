using System;
using System.Reflection;
using System.Windows;
using EdaTools.Utility;
using EdaTools.View;
using EdaTools.ViewModel;
using Elicon.Console.Config;
using Elicon.Domain;
using Elicon.Domain.GateLevel.Read;

namespace EdaTools
{
    public class ProgressUpdater : IEventSubscriber
    {
        private readonly EdaToolsMainViewModel _appViewModel;

        public ProgressUpdater(EdaToolsMainViewModel appViewModel)
        {
            _appViewModel = appViewModel;
        }

        public void Init(IPubSub pubSub)
        {
            pubSub.Subscribe<FileReadProgressEvent>(ProgressUpdaterDelegate);
        }

        private void ProgressUpdaterDelegate(FileReadProgressEvent ev)
        {
            _appViewModel.ProgressUpdater(ev);
        }
    }

    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);
            Bootstrapper.Boot(new Assembly[0]);
            var appMainWindow = new EdaToolsMainView();

            var viewModel = new EdaToolsMainViewModel();
            viewModel.CreateViewCloseCommand(appMainWindow);

            appMainWindow.DataContext = viewModel;
            appMainWindow.Show();

            var pubsub = Bootstrapper.Get<IPubSub>();
            var pu = new ProgressUpdater(viewModel);
            pu.Init(pubsub);
        }

    }
}
