﻿using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Reports.CountNativeModules
{
    public class CountNativeModulesReportWriteRequest : IReportWriteRequest
    {
        public string Destination { get; set; }
        public IDictionary<string, long> Data { get; set; }
    }
}