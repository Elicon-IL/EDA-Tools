using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.PhysicalModulePath
{
    public interface IPhysicalModulePathQuery
    {
        IDictionary<string, IList<string>> GetPhysicalPaths(string rootModule, IList<string> moduleNames);
    }
        
    public class PhysicalModulePathQuery : IPhysicalModulePathQuery
    {
        private readonly IModuleTraverser _moduleTraverser;

        public PhysicalModulePathQuery(IModuleTraverser moduleTraverser)
        {
            _moduleTraverser = moduleTraverser;
        }

        public IDictionary<string, IList<string>> GetPhysicalPaths(string rootModule, IList<string> moduleNames)
        {
            var visitor = new PhysicalModulePathInstanceVisitor();
            visitor.SetModulesToTrack(moduleNames);
            
            _moduleTraverser.Traverse(rootModule, visitor);

            return visitor.Result();
        }
    }
}

