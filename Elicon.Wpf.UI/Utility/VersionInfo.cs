using System;
using System.IO;
using System.Reflection;

namespace EdaTools.Utility
{
    public class VersionInfo
    {

        private readonly Assembly _assembly;

        public VersionInfo()
        {
            _assembly = Assembly.GetEntryAssembly();
        }

        public string Title
        {
            get
            {
                var title = GetAttributeValue<AssemblyTitleAttribute>(a => a.Title);
                return title ?? Path.GetFileNameWithoutExtension(_assembly.CodeBase);
            }
        }

        public string Version
        {
            get
            {
                var version = _assembly.GetName().Version;
                return version != null ? version.ToString() : "not defined";
            }
        }

        public string Description
        {
            get { return GetAttributeValue<AssemblyDescriptionAttribute>(a => a.Description); }
        }

        public string Product
        {
            get { return GetAttributeValue<AssemblyProductAttribute>(a => a.Product); }
        }

        public string Copyright
        {
            get { return GetAttributeValue<AssemblyCopyrightAttribute>(a => a.Copyright); }
        }

        public string Company
        {
            get { return GetAttributeValue<AssemblyCompanyAttribute>(a => a.Company); }
        }

        protected string GetAttributeValue<TAttr>(Func<TAttr, string> resolveFunc) where TAttr : Attribute
        {
            var attributes = _assembly.GetCustomAttributes(typeof(TAttr), false);
            return attributes.Length > 0 ? resolveFunc((TAttr)attributes[0]) : null;
        }

    }
}
