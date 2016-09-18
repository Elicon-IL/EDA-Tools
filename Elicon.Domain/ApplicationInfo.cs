using System;
using Elicon.Domain.GateLevel;

namespace Elicon.Domain
{
    public interface IApplicationInfo
    {
        Version AppVersion();
        string AppName { get; }
        string CompanyName { get; }
        string CompanyLink { get; }
    }

    public class ApplicationInfo : IApplicationInfo
    {
        public string AppName => "Verilog Gate-Level Studio";

        public string CompanyName => "Elicon";

        public string CompanyLink => "http://www.elicon.biz/";

        private readonly Version _appVersion = typeof(Instance).Assembly.GetName().Version;

        public Version AppVersion()
        {
            return _appVersion;
        }
    }
}
