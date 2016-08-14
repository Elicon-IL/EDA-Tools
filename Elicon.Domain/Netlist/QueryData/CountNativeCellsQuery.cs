using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;
using Elicon.Domain.Netlist.QueryData.Visitors;

namespace Elicon.Domain.Netlist.QueryData
{
    public interface ICountNativeCellsQuery
    {
        IDictionary<string, long> CountNativeCells(string rootModule);
    }

    public class CountNativeCellsQuery : ICountNativeCellsQuery
    {
        private readonly IModuleTraverser _moduleTraverser;
        private readonly ICountNativeCellsInstanceVisitor _countNativeCellsInstanceVisitor;

        public CountNativeCellsQuery(IModuleTraverser moduleTraverser, ICountNativeCellsInstanceVisitor countNativeCellsInstanceVisitor)
        {
            _moduleTraverser = moduleTraverser;
            _countNativeCellsInstanceVisitor = countNativeCellsInstanceVisitor;
        }

        public IDictionary<string, long> CountNativeCells(string rootModule)
        {
            _moduleTraverser.Traverse(rootModule, _countNativeCellsInstanceVisitor);

            return _countNativeCellsInstanceVisitor.Result();
        }
    }
}

