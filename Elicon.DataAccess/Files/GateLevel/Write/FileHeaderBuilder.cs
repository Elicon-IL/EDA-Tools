using System;
using System.Globalization;
using System.Text;
using Elicon.Domain;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Write
{
    public interface IFileHeaderBuilder
    {
        string BuildHeader(string action);
    }

    public class FileHeaderBuilder : IFileHeaderBuilder
    {
        private readonly IApplicationInfo _applicationInfo;

        public FileHeaderBuilder(IApplicationInfo applicationInfo)
        {
            _applicationInfo = applicationInfo;
        }

        public string BuildHeader(string action)
        {
            var sb = new StringBuilder();

            sb.AppendLine();
            sb.AppendLine("//");
            sb.AppendLine("// Type of action = {0}.".FormatWith(action));
            sb.AppendLine("// {0}".FormatWith(Time.Now().ToString("F", CultureInfo.CreateSpecificCulture("en-US"))));
            sb.AppendLine("// EdaTools - Verilog Gate-Level Studio - Version {0}"
                .FormatWith(_applicationInfo.AppVersion()));
            sb.AppendLine("//");
            sb.AppendLine();

            return sb.ToString();
        }
    }
}