using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Navigation;
using EdaTools.Utility;
using Elicon.Config;
using Elicon.Domain;

namespace EdaTools.View
{
    public partial class AboutEdaToolsView : Window
    {

        public static readonly DependencyProperty DlgTitleProperty = Utils.MakeStringDependencyProperty(typeof(AboutEdaToolsView), "DlgTitle");
        public static readonly DependencyProperty DescriptionProperty = Utils.MakeStringDependencyProperty(typeof(AboutEdaToolsView), "Description");
        public static readonly DependencyProperty VersionProperty = Utils.MakeStringDependencyProperty(typeof(AboutEdaToolsView), "Version");
        public static readonly DependencyProperty CopyrightProperty = Utils.MakeStringDependencyProperty(typeof(AboutEdaToolsView), "Copyright");
        public static readonly DependencyProperty CompanyProperty = Utils.MakeStringDependencyProperty(typeof(AboutEdaToolsView), "Company");

        protected AboutEdaToolsView()
        {
            InitializeComponent();
            DataContext = this;
            var ai = Bootstrapper.Get<IApplicationInfo>();
            Copyright = $"Copyright ©  2016 By {ai.CompanyName}";
            DlgTitle = "About " + ai.AppName;
            Company = ai.CompanyName;
            Version = $"Version {ai.AppVersion()}";
            Description = $"{ai.AppName} - {ai.AppDescription} for HW engineers";
        }

        public AboutEdaToolsView(Window parent)
            : this()
        {
            Owner = parent;
        }


        public string DlgTitle
        {
            get { return (string) GetValue(DlgTitleProperty); }
            set { SetValue(DlgTitleProperty, value); }
        }

        public string Description
        {
            get { return (string)GetValue(DescriptionProperty); }
            set { SetValue(DescriptionProperty, value); }
        }

        public string Version
        {
            get { return (string)GetValue(VersionProperty); }
            set { SetValue(VersionProperty, value); }
        }

        public string Copyright
        {
            get { return (string)GetValue(CopyrightProperty); }
            set { SetValue(CopyrightProperty, value); }
        }

        public string Company
        {
            get { return (string)GetValue(CompanyProperty); }
            set { SetValue(CompanyProperty, value); }
        }

        private void Hyperlink_RequestNavigate(object sender, RequestNavigateEventArgs e)
        {
            Process.Start(new ProcessStartInfo(e.Uri.AbsoluteUri));
            e.Handled = true;
        }
    }
}
