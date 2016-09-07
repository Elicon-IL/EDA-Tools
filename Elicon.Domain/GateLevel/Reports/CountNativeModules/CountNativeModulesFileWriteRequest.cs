using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Reports.CountNativeModules
{
    public class CountNativeModulesFileWriteRequest : IFileWriteRequest
    {
        public string Destination { get; set; }
        public string Action { get; set; } = "Count Native Modules";
        public IDictionary<string, long> Data { get; set; }
    }
}