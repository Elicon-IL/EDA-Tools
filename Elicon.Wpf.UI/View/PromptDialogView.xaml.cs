using System.Collections.Generic;
using System.Windows;
using EdaTools.Model;
using EdaTools.Utility;
using EdaTools.ViewModel;

namespace EdaTools.View
{
    public partial class PromptDialogView : Window
    {

        protected PromptDialogView()
        {
            InitializeComponent();
        }

        public PromptDialogView(Window parent, PromptDialogModel.Actions currentAction, List<string> loadedNetlists)
            : this()
        {
            Owner = parent;
            var viewModel = new PromptDialogViewModel { CurrentUiAction = currentAction, CloseAction = Close};
            viewModel.InitLoadedNetlists(loadedNetlists);
            viewModel.CreateViewCloseCommand(this);
            DataContext = viewModel;
        }
    }
}
