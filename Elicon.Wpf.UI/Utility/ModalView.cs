using System;
using System.Windows;

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
            return view.DataContext;
        }
    }

}
