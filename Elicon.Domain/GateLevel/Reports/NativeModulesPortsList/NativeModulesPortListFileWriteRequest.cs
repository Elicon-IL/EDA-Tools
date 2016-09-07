using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Reports.NativeModulesPortsList
{
    public class NativeModulesPortListFileWriteRequest : IFileWriteRequest
    {
        public string Destination { get; set; }
        public string Action { get; set; } = "Native Modules Port List";
        public IDictionary<string, string[]> Data { get; set; }
    }
}