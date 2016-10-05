using System.Reflection;
using System.Windows;
using EdaTools.View;
using EdaTools.ViewModel;
using Elicon.Config;
using Elicon.Domain;
using Elicon.Domain.GateLevel.Read;

namespace EdaTools
{
    public class ProgressUpdaterEventSubscriber : IEventSubscriber
    {
        private readonly IEdaToolsMainViewModel _appViewModel;

        public ProgressUpdaterEventSubscriber(IEdaToolsMainViewModel appViewModel)
        {
            _appViewModel = appViewModel;
        }

        public void Init(IPubSub pubSub)
        {
            pubSub.Subscribe<FileReadProgressEvent>(ProgressUpdaterDelegate);
        }

        private void ProgressUpdaterDelegate(FileReadProgressEvent ev)
        {
            _appViewModel.UpdateProgress(ev.Progress);
            _appViewModel.UpdateLog(ev);
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
