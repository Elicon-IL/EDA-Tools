using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.NativeModulesPortsList
{
    public interface INativeModulesPortListReport
    {
        IDictionary<string, string[]> GetNativeModulesPortsList(string source, string destination);
    }

    public class NativeModulesPortListReport : INativeModulesPortListReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly INativeModulesPortListQuery _nativeModulesPortListQuery;
        private readonly IFileWriter _fileWriter;

        public NativeModulesPortListReport(INativeModulesPortListQuery nativeModulesPortListQuery, INetlistDataBuilder netlistDataBuilder, IFileWriter fileWriter)
        {
            _nativeModulesPortListQuery = nativeModulesPortListQuery;
            _netlistDataBuilder = netlistDataBuilder;
            _fileWriter = fileWriter;
        }

        public IDictionary<string, string[]> GetNativeModulesPortsList(string source, string destination)
        {
            _netlistDataBuilder.Build(source);

            var result = _nativeModulesPortListQuery.GetNativeModulesPortsList(source);

            _fileWriter.Write(new NativeModulesPortListFileWriteRequest {
                Destination = destination,
                Data = result
            });

            return result;
        }
    }
}

