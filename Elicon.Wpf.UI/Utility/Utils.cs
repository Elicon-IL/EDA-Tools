using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Windows;
using System.Windows.Data;
using EdaTools.ViewModel;

namespace EdaTools.Utility
{
    public static class Utils
    {

        public static bool VerifyProperty(this object component, string propertyName)
        {
            return TypeDescriptor.GetProperties(component)[propertyName] == null;
        }

        public static DependencyProperty MakeStringDependencyProperty(Type owner, string propertyName)
        {
            return DependencyProperty.Register(propertyName, typeof(string), owner, new UIPropertyMetadata(string.Empty));
        }

        public static DependencyProperty MakeBooleanDependencyProperty(Type owner, string propertyName)
        {
            return DependencyProperty.Register(propertyName, typeof(bool), owner, new UIPropertyMetadata(false));
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
            if (collectionView != null)
                collectionView.MoveCurrentTo(view);
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
