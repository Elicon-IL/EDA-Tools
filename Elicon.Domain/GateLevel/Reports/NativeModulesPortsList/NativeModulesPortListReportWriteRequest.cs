using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Reports.NativeModulesPortsList
{
    public class NativeModulesPortListReportWriteRequest : IReportWriteRequest
    {
        public string Destination { get; set; }
        public string Action { get; } = "Native Modules Port List";
        public IDictionary<string, string[]> Data { get; set; }
    }
}