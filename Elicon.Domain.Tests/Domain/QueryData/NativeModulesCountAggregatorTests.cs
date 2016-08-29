using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.QueryData.CountNativeModules;
using Elicon.Domain.GateLevel.QueryData.Traversal;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.QueryData
{
    [TestFixture]
    public class NativeModulesCountAggregatorTests
    {
        private NativeModulesCountAggregator _target;

        [SetUp]
        public void SetUp()
        {
            _target = new NativeModulesCountAggregator();
        }

        [Test]
        public void Collect_InstanceNotNative_NotCollected()
        {
            var instance = new Instance("netlist", "host", "moduleName", "instName") {Type = InstanceType.Module};

            _target.Collect(new TraversalState { CurrentInstance = instance });

            var result = _target.Result();
            Assert.That(result,Is.Empty);
        }

        [Test]
        public void Collect_InstanceNative_Collected()
        {
            var instance = new Instance("netlist", "host", "moduleName", "instName") { Type = InstanceType.Native };

            _target.Collect(new TraversalState { CurrentInstance = instance });

            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result["moduleName"], Is.EqualTo(1));
        }

        [Test]
        public void Collect_TwoNativeInstances_Collected()
        {
            var instance = new Instance("netlist", "host", "moduleName", "instName") { Type = InstanceType.Native };
            _target.Collect(new TraversalState { CurrentInstance = instance });
            instance = new Instance("netlist", "host", "moduleName2", "instName1") { Type = InstanceType.Native };
            _target.Collect(new TraversalState { CurrentInstance = instance });
            instance = new Instance("netlist", "host", "moduleName", "instName2") { Type = InstanceType.Native };
            _target.Collect(new TraversalState { CurrentInstance = instance });

            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(2));
            Assert.That(result["moduleName"], Is.EqualTo(2));
            Assert.That(result["moduleName2"], Is.EqualTo(1));
        }
    }
}

