using System.Collections.Generic;
using Elicon.Domain.GateLevel.Reports.CountNativeModules;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class CountNativeModulesQueryTests : IntegrationTestBase
    {
        private ICountNativeModulesQuery _target;

        [SetUp]
        public void SetUp()
        {
            _target = Get<ICountNativeModulesQuery>();
        }

        [Test]
        public void CountNativeModules_NetlistWithNativeModules_ReturnsAllNativeModulesCount()
        {
            var result = _target.CountNativeModules(ExampleNetlistFilePath, ExampleNetlistTopModule);

            var expected = new List<NativeModuleCount> {
                new NativeModuleCount("an2", 1135),new NativeModuleCount("an3", 446),new NativeModuleCount("an4", 158),
                new NativeModuleCount("aoi21", 50),new NativeModuleCount("aoi22", 4),new NativeModuleCount("aoi31", 11),
                new NativeModuleCount("b1", 153),new NativeModuleCount("bd", 25),new NativeModuleCount("cvdd", 11),
                new NativeModuleCount("cvss", 59),new NativeModuleCount("dspbrs", 560),new NativeModuleCount("i1", 1140),
                new NativeModuleCount("ic", 15),new NativeModuleCount("iobhc", 10),new NativeModuleCount("mx21", 1742),
                new NativeModuleCount("mx21i", 695),new NativeModuleCount("mx41", 142),new NativeModuleCount("na2", 265),
                new NativeModuleCount("na3", 19),new NativeModuleCount("na4", 7),new NativeModuleCount("no2", 86),
                new NativeModuleCount("no3", 42),new NativeModuleCount("no4", 8),new NativeModuleCount("oai21", 27),
                new NativeModuleCount("or2", 779),new NativeModuleCount("or3", 4),new NativeModuleCount("or4", 7),
                new NativeModuleCount("oth", 23),new NativeModuleCount("por", 1),new NativeModuleCount("xn2", 9),
                new NativeModuleCount("xo2", 605),new NativeModuleCount("oai22", 1),new NativeModuleCount("oai211", 1)
            };

            Assert.That(result, Is.EquivalentTo(expected));
        }
    }
 }