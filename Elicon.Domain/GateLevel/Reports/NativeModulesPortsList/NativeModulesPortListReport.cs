using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.NativeModulesPortsList
{
    public interface INativeModulesPortListFileContentDirector
    {
        string Construct(IList<NativeModulePorts> data);
    }

    public interface INativeModulesPortListReport
    {
        IList<NativeModulePorts> GetNativeModulesPortsList(string source, string destination);
    }

    public class NativeModulesPortListReport : INativeModulesPortListReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly INativeModulesPortListQuery _nativeModulesPortListQuery;
        private readonly INativeModulesPortListFileContentDirector _nativeModulesPortListFileContentDirector;
        private readonly IFileWriter _fileWriter;

        public NativeModulesPortListReport(INativeModulesPortListQuery nativeModulesPortListQuery, INetlistDataBuilder netlistDataBuilder, IFileWriter fileWriter, INativeModulesPortListFileContentDirector nativeModulesPortListFileContentDirector)
        {
            _nativeModulesPortListQuery = nativeModulesPortListQuery;
            _netlistDataBuilder = netlistDataBuilder;
            _fileWriter = fileWriter;
            _nativeModulesPortListFileContentDirector = nativeModulesPortListFileContentDirector;
        }

        public IList<NativeModulePorts> GetNativeModulesPortsList(string source, string destination)
        {
            _netlistDataBuilder.Build(source);

            var result = _nativeModulesPortListQuery.GetNativeModulesPortsList(source);

            var content = _nativeModulesPortListFileContentDirector.Construct(result);
            _fileWriter.Write(destination, "Native Modules Port List", content);

            return result;
        }
    }
}

