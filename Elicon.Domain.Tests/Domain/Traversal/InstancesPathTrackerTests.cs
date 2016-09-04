using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Traversal.PhysicalTraversal;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Traversal
{
    [TestFixture]
    public class InstancesPathTrackerTests
    {
        private InstancesPathTracker _target;

        [SetUp]
        public void SetUp()
        {
            _target = new InstancesPathTracker();
        }

        [Test]
        public void UpdateIn_InstanceWithoutInstanceName_NoUpdate()
        {
            var instance = new Instance("netlist", "hostModule", "moduleName", "");

            _target.UpdateIn(instance);

            var result = _target.ToString();
            Assert.That(result, Is.Empty);
        }

        [Test]
        public void UpdateIn_InstanceWithInstanceName_Update()
        {
            var instance = new Instance("netlist", "hostModule", "moduleName", "inst1");

            _target.UpdateIn(instance);

            var result = _target.ToString();
            Assert.That(result, Is.EqualTo("inst1"));
        }

        [Test]
        public void UpdateIn_TwoInstancesWithInstanceName_Update()
        {
            var instance = new Instance("netlist", "hostModule", "moduleName", "inst1");
            var instance2 = new Instance("netlist", "hostModule2", "moduleName", "inst2");

            _target.UpdateIn(instance);
            _target.UpdateIn(instance2);

            var result = _target.ToString();
            Assert.That(result, Is.EqualTo("inst1/inst2"));
        }

        [Test]
        public void UpdateOut_EmptyTracker_NotThrows()
        {    
            Assert.DoesNotThrow(() =>_target.UpdateOut());   
        }

        [Test]
        public void UpdateOut_OneInstance_Update()
        {
            var instance = new Instance("netlist", "hostModule", "moduleName", "inst1");
            _target.UpdateIn(instance);

            _target.UpdateOut();

            var result = _target.ToString();
            Assert.That(result, Is.Empty);
        }

        [Test]
        public void UpdateOut_TwoInstances_Update()
        {
            var instance = new Instance("netlist", "hostModule", "moduleName", "inst1");
            var instance2 = new Instance("netlist", "hostModule2", "moduleName", "inst2");
            _target.UpdateIn(instance);
            _target.UpdateIn(instance2);
            
            _target.UpdateOut();

            var result = _target.ToString();
            Assert.That(result, Is.EqualTo("inst1"));
        }
    }
}

