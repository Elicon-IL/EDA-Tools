using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.CountNativeModules
{
    public interface ICountNativeModulesReport
    {
        IDictionary<string, long> CountNativeModules(string source, string rootModule, string destination);
    }

    public class CountNativeModulesReport : ICountNativeModulesReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly ICountNativeModulesQuery _countNativeModulesQuery;
        private readonly IFileWriter _fileWriter;

        public CountNativeModulesReport(INetlistDataBuilder netlistDataBuilder, ICountNativeModulesQuery countNativeModulesQuery, IFileWriter fileWriter)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _countNativeModulesQuery = countNativeModulesQuery;
            _fileWriter = fileWriter;
        }

        public IDictionary<string, long> CountNativeModules(string source, string rootModule, string destination)
        {
            _netlistDataBuilder.Build(source);

            var result = _countNativeModulesQuery.CountNativeModules(source, rootModule);

            _fileWriter.Write(new CountNativeModulesFileWriteRequest {
                Destination = destination,
                Data = result
            });

            return result;
        }

       
    }
}

