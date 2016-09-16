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
        IList<LibraryGate> GetLibraryGates(string source, string destination);
    }

    public class ListLibraryGatesLibraryGatesReport : IListLibraryGatesReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly IListLibraryGatesQuery _listLibraryGatesQuery;
        private readonly IListLibraryGatesFileContentDirector _listLibraryGatesFileContentDirector;
        private readonly IFileWriter _fileWriter;

        public ListLibraryGatesLibraryGatesReport(IListLibraryGatesQuery listLibraryGatesQuery, INetlistDataBuilder netlistDataBuilder, IFileWriter fileWriter, IListLibraryGatesFileContentDirector listLibraryGatesFileContentDirector)
        {
            _listLibraryGatesQuery = listLibraryGatesQuery;
            _netlistDataBuilder = netlistDataBuilder;
            _fileWriter = fileWriter;
            _listLibraryGatesFileContentDirector = listLibraryGatesFileContentDirector;
        }

        public IList<LibraryGate> GetLibraryGates(string source, string destination)
        {
            _netlistDataBuilder.Build(source);

            var result = _listLibraryGatesQuery.GetLibraryGates(source);

            var content = _listLibraryGatesFileContentDirector.Construct(result);
            _fileWriter.Write(destination, "LibraryGate Modules Port List", content);

            return result;
        }
    }
}

