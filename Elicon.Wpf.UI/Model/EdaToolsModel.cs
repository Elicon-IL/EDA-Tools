using System.Collections.Generic;

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
        private readonly List<string> _loadedNetlists;


        public EdaToolsModel()
        {
            _loadedNetlists = new List<string>();
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
