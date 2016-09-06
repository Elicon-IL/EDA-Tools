using System;
using System.Globalization;
using System.Text;
using Elicon.Domain;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write
{
    public interface IFileTitleBuilder
    {
        string BuildTitle(string action);
    }

    public class FileTitleBuilder : IFileTitleBuilder
    {
        private readonly IApplicationInfo _applicationInfo;

        public FileTitleBuilder(IApplicationInfo applicationInfo)
        {
            _applicationInfo = applicationInfo;
        }

        public string BuildTitle(string action)
        {
            var sb = new StringBuilder();

            sb.AppendLine("//");
            sb.AppendLine("// Type of action = {0}.".FormatWith(action));
            sb.AppendLine("// {0}".FormatWith(DateTime.UtcNow.ToString("F", CultureInfo.CreateSpecificCulture("en-US"))));
            sb.AppendLine("// EdaTools - Verilog Gate-Level Studio - Version {0}"
                .FormatWith(_applicationInfo.AppVersion()));
            sb.AppendLine("//");

            return sb.ToString();
        }
    }
}