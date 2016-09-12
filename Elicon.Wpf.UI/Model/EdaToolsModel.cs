using System.Collections.Generic;
using System.Windows;

namespace EdaTools.Model
{
    public class EdaToolsModel
    {

        // ====================================================
        // Model Properties.
        // ====================================================

        private string _netlistReadFilePath = "";
        private string _logWindowContents = "";
        private int _progressBarValue;
        private Visibility _progressBarVisibility;
        private readonly List<string> _loadedNetlists;


        public EdaToolsModel()
        {
            _loadedNetlists = new List<string>();
            _progressBarVisibility = Visibility.Hidden;
        }

        public int CountNetlists
        {
            get { return _loadedNetlists.Count; }
        }

        public string NetlistReadFilePath
        {
            get { return _netlistReadFilePath; }
            set { _netlistReadFilePath = value; }
        }

        public string LogWindowContents
        {
            get { return _logWindowContents; }
            set { _logWindowContents = value; }
        }

        public Visibility ProgressBarVisibility
        {
            get { return _progressBarVisibility; }
            set { _progressBarVisibility = value; }
        }

        public int ProgressBarValue
        {
            get { return _progressBarValue; }
            set { _progressBarValue = value; }
        }

        public List<string> LoadedNetlists
        {
            get { return _loadedNetlists; }
            set
            {
                _loadedNetlists.Clear();
                _loadedNetlists.AddRange(value);
            }
        }


    }
}
