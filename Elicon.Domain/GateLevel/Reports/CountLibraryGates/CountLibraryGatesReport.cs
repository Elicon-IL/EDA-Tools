using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.CountLibraryGates
{
    public interface ICountLibraryGatesFileContentDirector
    {
        string Construct(IList<LibraryGateCount> data);
    }

    public interface ICountLibraryGatesReport
    {
        void GenerateReport(string source, string rootModule, string destination);
    }

    public class CountLibraryGatesReport : ICountLibraryGatesReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly ICountLibraryGatesQuery _countLibraryGatesQuery;
        private readonly ICountLibraryGatesFileContentDirector _countLibraryGatesFileContentDirector;
        private readonly IFileWriter _fileWriter;

        public CountLibraryGatesReport(INetlistDataBuilder netlistDataBuilder, ICountLibraryGatesQuery countLibraryGatesQuery, IFileWriter fileWriter, ICountLibraryGatesFileContentDirector countLibraryGatesFileContentDirector)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _countLibraryGatesQuery = countLibraryGatesQuery;
            _fileWriter = fileWriter;
            _countLibraryGatesFileContentDirector = countLibraryGatesFileContentDirector;
        }

        public void GenerateReport(string source, string rootModule, string destination)
        {
            _netlistDataBuilder.Build(source);

            var result = _countLibraryGatesQuery.CountLibraryGates(source, rootModule);

            var content = _countLibraryGatesFileContentDirector.Construct(result);
            _fileWriter.Write(destination, "Count Library Gates", content);
        }
    }
}

