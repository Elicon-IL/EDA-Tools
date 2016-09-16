using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.ListPhysicalPaths
{
    public interface IListPhysicalPathsFileContentDirector
    {
        string Construct(IList<string> modulesToList, IList<ModulePhysiclaPaths> data);
    }

    public interface IListPhysicalPathsReport
    {
        IList<ModulePhysiclaPaths> GetPhysicalPaths(string source, string rootModule, IList<string> moduleNames, string destination);
    }
        
    public class ListPhysicalPathsReport : IListPhysicalPathsReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly IPhysicalPathQuery _physicalPathQuery;
        private readonly IListPhysicalPathsFileContentDirector _listPhysicalPathsFileContentDirector;
        private readonly IFileWriter _fileWriter;

        public ListPhysicalPathsReport(INetlistDataBuilder netlistDataBuilder, IPhysicalPathQuery physicalPathQuery, IFileWriter fileWriter, IListPhysicalPathsFileContentDirector listPhysicalPathsFileContentDirector)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _physicalPathQuery = physicalPathQuery;
            _fileWriter = fileWriter;
            _listPhysicalPathsFileContentDirector = listPhysicalPathsFileContentDirector;
        }

        public IList<ModulePhysiclaPaths> GetPhysicalPaths(string source, string rootModule, IList<string> moduleNames, string destination)
        {
            _netlistDataBuilder.Build(source);
          
            var result = _physicalPathQuery.GetPhysicalPaths(source, rootModule, moduleNames);

            var content = _listPhysicalPathsFileContentDirector.Construct(moduleNames, result);
            _fileWriter.Write(destination, "List Phyisical Paths", content);

            return result;
        }
    }
}

