using System.ComponentModel;

namespace EdaTools.Utility
{
    public abstract class NotifyPropertyChanged : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            var handler = PropertyChanged;
            if (this.VerifyProperty(propertyName) && handler != null)
            {
                var e = new PropertyChangedEventArgs(propertyName);
                PropertyChanged(this, e);
            }
        }

        protected void RaisePropertyChanged(string propertyName)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    }
}
