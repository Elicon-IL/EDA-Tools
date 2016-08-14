using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;
using Elicon.Domain.Netlist.QueryData.Visitors;

namespace Elicon.Domain.Netlist.QueryData
{
    public interface IPhysicalModulePathQuery
    {
        IDictionary<string, IList<string>> GetPhysicalPaths(string rootModule, IList<string> moduleNames);
    }
        
    public class PhysicalModulePathQuery : IPhysicalModulePathQuery
    {
        private readonly IPhysicalPathInstanceVisitor _physicalPathInstanceVisitor;
        private readonly IModuleTraverser _moduleTraverser;

        public PhysicalModulePathQuery(IPhysicalPathInstanceVisitor physicalPathInstanceVisitor, IModuleTraverser moduleTraverser)
        {
            _physicalPathInstanceVisitor = physicalPathInstanceVisitor;
            _moduleTraverser = moduleTraverser;
        }
        
        public IDictionary<string, IList<string>> GetPhysicalPaths(string rootModule, IList<string> moduleNames)
        {
            _physicalPathInstanceVisitor.SetModulesToTrack(moduleNames);
            _moduleTraverser.Traverse(rootModule, _physicalPathInstanceVisitor);

            return _physicalPathInstanceVisitor.Result();
        }
    }
}

