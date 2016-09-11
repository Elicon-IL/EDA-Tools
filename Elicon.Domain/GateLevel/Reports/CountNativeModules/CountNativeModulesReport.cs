using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.CountNativeModules
{
    public interface ICountNativeModulesFileContentDirector
    {
        string Construct(IList<NativeModuleCount> data);
    }

    public interface ICountNativeModulesReport
    {
        IList<NativeModuleCount> CountNativeModules(string source, string rootModule, string destination);
    }

    public class CountNativeModulesReport : ICountNativeModulesReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly ICountNativeModulesQuery _countNativeModulesQuery;
        private readonly ICountNativeModulesFileContentDirector _countNativeModulesFileContentDirector;
        private readonly IFileWriter _fileWriter;

        public CountNativeModulesReport(INetlistDataBuilder netlistDataBuilder, ICountNativeModulesQuery countNativeModulesQuery, IFileWriter fileWriter, ICountNativeModulesFileContentDirector countNativeModulesFileContentDirector)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _countNativeModulesQuery = countNativeModulesQuery;
            _fileWriter = fileWriter;
            _countNativeModulesFileContentDirector = countNativeModulesFileContentDirector;
        }

        public IList<NativeModuleCount> CountNativeModules(string source, string rootModule, string destination)
        {
            _netlistDataBuilder.Build(source);

            var result = _countNativeModulesQuery.CountNativeModules(source, rootModule);

            var content = _countNativeModulesFileContentDirector.Construct(result);
            _fileWriter.Write(destination, "Count Native Modules", content);

            return result;
        }
    }
}

