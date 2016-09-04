using System;
using System.ComponentModel;
using System.Windows.Input;
using EdaTools.Utility;

namespace EdaTools.ViewModel
{
    public abstract class ViewModelBase : NotifyPropertyChanged
    {
        public virtual string DisplayName { get; protected set; }
        public event EventHandler UiCloseRequest;
        private RelayCommand _close;

        public ICommand Close
        {
            get { return _close ?? (_close = new RelayCommand(param => OnUiCloseRequest())); }
        }

        private void OnUiCloseRequest()
        {
            if (UiCloseRequest != null)
                UiCloseRequest(this, EventArgs.Empty);
        }

        public virtual void OnViewModelPropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            OnPropertyChanged(e.PropertyName);
        }

    }
}