using System;
using System.Diagnostics;
using System.Windows.Input;

namespace EdaTools.Utility
{

    public class RelayCommand : ICommand
    {

        readonly Action<object> _commandLogic;
        readonly Predicate<object> _canExecute;        


        public RelayCommand(Action<object> commandLogic)
            : this(commandLogic, null)
        {
        }

        public RelayCommand(Action<object> commandLogic, Predicate<object> canExecute)
        {
            if (commandLogic == null)
                throw new ArgumentNullException("commandLogic");

            _commandLogic = commandLogic;
            _canExecute = canExecute;           
        }


        [DebuggerStepThrough]
        public bool CanExecute(object parameter)
        {
            // NOTE: The default return value is 'true'.
            return _canExecute == null || _canExecute(parameter);
        }

        public event EventHandler CanExecuteChanged
        {
            add { CommandManager.RequerySuggested += value; }
            remove { CommandManager.RequerySuggested -= value; }
        }

        public void Execute(object parameter)
        {
            _commandLogic(parameter);
        }

    }
}