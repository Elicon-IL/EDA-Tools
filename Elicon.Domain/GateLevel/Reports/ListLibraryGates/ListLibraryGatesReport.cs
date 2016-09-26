using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.ListLibraryGates
{
    public interface IListLibraryGatesFileContentDirector
    {
        string Construct(IList<LibraryGate> data);
    }

    public interface IListLibraryGatesReport
    {
        void GenerateReport(string source, string destination);
    }

    public class ListLibraryGatesReport : IListLibraryGatesReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly IListLibraryGatesQuery _listLibraryGatesQuery;
        private readonly IListLibraryGatesFileContentDirector _listLibraryGatesFileContentDirector;
        private readonly IFileWriter _fileWriter;

        public ListLibraryGatesReport(IListLibraryGatesQuery listLibraryGatesQuery, INetlistDataBuilder netlistDataBuilder, IFileWriter fileWriter, IListLibraryGatesFileContentDirector listLibraryGatesFileContentDirector)
        {
            _listLibraryGatesQuery = listLibraryGatesQuery;
            _netlistDataBuilder = netlistDataBuilder;
            _fileWriter = fileWriter;
            _listLibraryGatesFileContentDirector = listLibraryGatesFileContentDirector;
        }

        public void GenerateReport(string source, string destination)
        {
            _netlistDataBuilder.Build(source);

            var result = _listLibraryGatesQuery.GetLibraryGates(source);

            var content = _listLibraryGatesFileContentDirector.Construct(result);
            _fileWriter.Write(destination, "List Library Gates", content);
        }
    }
}

