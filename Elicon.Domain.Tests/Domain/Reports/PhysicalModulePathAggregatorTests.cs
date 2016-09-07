using System.Collections.Generic;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Reports.PhysicalModulePath;
using Elicon.Domain.GateLevel.Traversal.PhysicalTraversal;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Reports
{
    [TestFixture]
    public class PhysicalModulePathAggregatorTests
    {
        private PhysicalModulePathAggregator _target;

        [Test]
        public void Collect_NoModuleToCollectSpecified_NotCollected()
        {
            var moduleNamesToCollect = new List<string>();
            _target = new PhysicalModulePathAggregator(moduleNamesToCollect);

            _target.Collect(new TraversalState {
                CurrentInstance = new Instance("netlist", "host", "moduleName", "instName"),
                InstancesPathTracker = new InstancesPathTracker()
            });

            var result = _target.Result();
            Assert.That(result,Is.Empty);
        }

        [Test]
        public void Collect_OneModuleToCollectAndOnePath_Collected()
        {
            const string moduleNameToCollect = "moduleName";
            var moduleNamesToCollect = new List<string> { moduleNameToCollect };
            var traversalState = new TraversalState { CurrentInstance = new Instance("netlist", "host", moduleNameToCollect, "instName") };
            var instancesPathTracker = new InstancesPathTracker().UpdateIn(traversalState.CurrentInstance);
            traversalState.InstancesPathTracker = instancesPathTracker;

            _target = new PhysicalModulePathAggregator(moduleNamesToCollect);
            _target.Collect(traversalState);
           
            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result, Has.Exactly(1).Matches<ModulePhysiclaPaths>(mpp =>
                mpp.ModuleName == moduleNameToCollect
                && mpp.Paths.Count == 1
                && mpp.Paths[0] == instancesPathTracker.ToString()
                ));
        }
    }
}

