using System;
using Elicon.Domain.GateLevel;

namespace Elicon.Domain
{
    public interface IApplicationInfo
    {
        Version AppVersion();
    }

    public class ApplicationInfo : IApplicationInfo
    {
        private readonly Version _appVersion = typeof(Instance).Assembly.GetName().Version;

        public Version AppVersion()
        {
            return _appVersion;
        }
    }
}