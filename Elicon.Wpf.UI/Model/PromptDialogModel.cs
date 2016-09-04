using System;

namespace EdaTools.Model
{
    public class PromptDialogModel
    {

        public enum Actions
        {
            None,
            ListPhysicalInstances,
            CountPhysicalInstances,
            ListUndeclaredModules,
            UCasePorts,
            RemoveBuffers,
            ReplaceModule
        };

        public bool CanExecute(Actions currentUiAction)
        {
            if (SelectedNetlistIndex >= 0)
                if (!String.IsNullOrEmpty(TargetSaveFile))
                {
                    switch (currentUiAction)
                    {
                        case Actions.UCasePorts:
                        case Actions.ListUndeclaredModules:
                            return true;
                        case Actions.RemoveBuffers:
                        case Actions.CountPhysicalInstances:
                            return !String.IsNullOrEmpty(UserData1);
                        case Actions.ReplaceModule:
                        case Actions.ListPhysicalInstances:
                            if (!String.IsNullOrEmpty(UserData1))
                                if (!String.IsNullOrEmpty(UserData2))
                                    return true;
                            break;
                    }
                }
            return false;
        }

        // ====================================================
        // Model Properties.
        // ====================================================
        private string _dialogTitle = "";
        private string _targetSaveFile = "";
        private string _userData1 = "";
        private string _userPrompt1 = "";
        private string _userData2 = "";
        private string _userPrompt2 = "";

        private int _selectedNetlistIndex = -1;

        public PromptDialogModel()
        {
            _userData1 = "multiplier_32x32";
        }

        public string DialogTitle
        {
            get { return _dialogTitle; }
            set { _dialogTitle = value; }
        }

        public string TargetSaveFile
        {
            get { return _targetSaveFile; }
            set { _targetSaveFile = value; }
        }

        public int SelectedNetlistIndex
        {
            get { return _selectedNetlistIndex; }
            set { _selectedNetlistIndex = value; }

        }

        public string UserData1
        {
            get { return _userData1; }
            set { _userData1 = value; }
        }

        public string UserPrompt1
        {
            get { return _userPrompt1; }
            set {_userPrompt1 = value; }
        }

        public string UserData2
        {
            get { return _userData2; }
            set { _userData2 = value; }
        }

        public string UserPrompt2
        {
            get { return _userPrompt2; }
            set{_userPrompt2 = value; }
        }

    }
}
