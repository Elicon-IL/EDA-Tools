﻿using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Reports.CountLibraryGates;
using Elicon.Domain.GateLevel.Traversal.PhysicalTraversal;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Reports
{
    [TestFixture]
    public class LibraryGatesCountAggregatorTests
    {
        private LibraryGatesCountAggregator _target;

        [SetUp]
        public void SetUp()
        {
            _target = new LibraryGatesCountAggregator();
        }

        [Test]
        public void Collect_InstanceNotLibraryGate_NotCollected()
        {
            var instance = new Instance("netlist", "host", "moduleName", "instName") {Type = InstanceType.Module};

            _target.Collect(new TraversalState { CurrentInstance = instance });

            var result = _target.Result();
            Assert.That(result,Is.Empty);
        }

        [Test]
        public void Collect_InstanceIsLibraryGate_Collected()
        {
            var instance = new Instance("netlist", "host", "moduleName", "instName") { Type = InstanceType.LibraryGate };

            _target.Collect(new TraversalState { CurrentInstance = instance });

            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result, Has.Exactly(1).Matches<LibraryGateCount>(mc => mc.ModuleName == "moduleName" && mc.Count == 1));
        }

        [Test]
        public void Collect_TwoLibraryGateInstances_Collected()
        {
            var instance = new Instance("netlist", "host", "moduleName", "instName") { Type = InstanceType.LibraryGate };
            _target.Collect(new TraversalState { CurrentInstance = instance });
            instance = new Instance("netlist", "host", "moduleName2", "instName1") { Type = InstanceType.LibraryGate };
            _target.Collect(new TraversalState { CurrentInstance = instance });
            instance = new Instance("netlist", "host", "moduleName", "instName2") { Type = InstanceType.LibraryGate };
            _target.Collect(new TraversalState { CurrentInstance = instance });

            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(2));
            Assert.That(result, Has.Exactly(1).Matches<LibraryGateCount>(mc => mc.ModuleName == "moduleName" && mc.Count == 2));
            Assert.That(result, Has.Exactly(1).Matches<LibraryGateCount>(mc => mc.ModuleName == "moduleName2" && mc.Count == 1));
        }
    }
}

