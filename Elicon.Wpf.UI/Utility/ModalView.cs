using System;
using System.Windows;
using EdaTools.ViewModel;

namespace EdaTools.Utility
{

    public class RequestCloseEventArgs : EventArgs
    {
        public RequestCloseEventArgs(object viewModelOutputData)
        {
            ViewModelOutputData = viewModelOutputData;
        }

        public object ViewModelOutputData
        {
            get;
            private set;
        }
    }

    public static class ModalView
    {
        public static object ShowModal(this Window view)
        {
            view.ShowDialog();
            var dataContext = (ViewModelBase) view.DataContext;
            return dataContext != null ? (dataContext.ViewModelOutputData ?? false) : false;
        }

    }



    

}
