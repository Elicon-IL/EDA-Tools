using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Windows;
using System.Windows.Data;
using EdaTools.ViewModel;

namespace EdaTools.Utility
{
    public static class Utils
    {

        public static DependencyProperty MakeStringDependencyProperty(Type owner, string propertyName)
        {
            return DependencyProperty.Register(propertyName, typeof(string), owner, new UIPropertyMetadata(string.Empty));
        }

        public static DependencyProperty MakeBooleanDependencyProperty(Type owner, string propertyName, bool init = false)
        {
            return DependencyProperty.Register(propertyName, typeof(bool), owner, new UIPropertyMetadata(init));
        }

        public static DependencyProperty MakeTypedDependencyProperty(Type owner, string propertyName, Type propertyType)
        {
            return DependencyProperty.Register(propertyName, propertyType, owner, new UIPropertyMetadata(null));
        }

        public static void CreateViewCloseCommand(this ViewModelBase viewModelBase, Window view)
        {
            EventHandler handler = null;
            handler = delegate
            {
                viewModelBase.UiCloseRequest -= handler;
                view.Close();
            };
            viewModelBase.UiCloseRequest += handler;
        }

        public static void SetActiveWindow(this ViewModelBase view, ObservableCollection<ViewModelBase> childWindows)
        {
            Debug.Assert(childWindows.Contains(view));

            var collectionView = CollectionViewSource.GetDefaultView(childWindows);
            collectionView?.MoveCurrentTo(view);
        }

        public static List<string> CommaSeparatedStringToList(this string listOfNames)
        {
            return listOfNames.Split(' ').Select(item => item.Trim()).Where(trimmedItem => trimmedItem.Length > 0).ToList();
        }

        public static string FormatMessage(this Exception ex)
        {
            return ex.InnerException == null ? $"ERROR - Exception = {ex.Message}" : $"ERROR - Exception = {ex.Message}{Environment.NewLine}Inner Exception = {ex.InnerException.Message}";
        }

        public static string AppendLine(this string source, string newLine)
        {
            if (String.IsNullOrEmpty(source))
                return newLine;
            return source + Environment.NewLine + newLine;
        }

        public static string GetPathParent(int countLevels)
        {
            var dllDirName = Path.GetDirectoryName(Assembly.GetExecutingAssembly().CodeBase);
            if (dllDirName != null)
            {
                var dllDirectory = new Uri(dllDirName).LocalPath;
                for (var i = 0; i < countLevels; i++)
                {
                    dllDirectory = Directory.GetParent(dllDirectory).FullName;
                }
                return dllDirectory;
            }
            return null;
        }
    }
}
