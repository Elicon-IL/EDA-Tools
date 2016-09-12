using System.Reflection;
using System.Windows;
using EdaTools.View;
using EdaTools.ViewModel;
using Elicon.Console.Config;
using Elicon.Domain;
using Elicon.Domain.GateLevel.Read;

namespace EdaTools
{
    public class ProgressUpdaterEventSubscriber : IEventSubscriber
    {
        private readonly EdaToolsMainViewModel _appViewModel;

        public ProgressUpdaterEventSubscriber(EdaToolsMainViewModel appViewModel)
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
            Bootstrapper.Boot(new[] {Assembly.GetExecutingAssembly() });
            var appMainWindow = new EdaToolsMainView();

            var viewModel = Bootstrapper.Get<IEdaToolsMainViewModel>();
            viewModel.CreateAppCloseCommand(appMainWindow);
            appMainWindow.DataContext = viewModel;
            appMainWindow.Show();
        }
    }
}
