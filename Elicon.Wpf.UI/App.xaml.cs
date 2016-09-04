using System;
using System.Windows;
using EdaTools.Utility;
using EdaTools.View;
using EdaTools.ViewModel;

namespace EdaTools
{

    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);
            var appMainWindow = new EdaToolsMainView();

            var viewModel = new EdaToolsMainViewModel();
            viewModel.CreateViewCloseCommand(appMainWindow);

            appMainWindow.DataContext = viewModel;
            appMainWindow.Show();
        }

        private void AppDispatcherUnhandledException(object sender, System.Windows.Threading.DispatcherUnhandledExceptionEventArgs e)
        {
            //
            // TODO: Replace with a custom alert-box and add exception to the status window. 
            //
            MessageBox.Show("An unhandled exception just occurred: " + e.Exception.Message, "Exception Sample", MessageBoxButton.OK, MessageBoxImage.Warning);
            e.Handled = true;
        }

    }
}
