using System;
using System.Windows;
using EdaTools.Utility;
using EdaTools.View;
using EdaTools.ViewModel;
using Elicon.Console.Config;

namespace EdaTools
{

    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);
            Bootstrapper.Boot();
            var appMainWindow = new EdaToolsMainView();

            var viewModel = new EdaToolsMainViewModel();
            viewModel.CreateViewCloseCommand(appMainWindow);

            appMainWindow.DataContext = viewModel;
            appMainWindow.Show();
        }

    }
}
