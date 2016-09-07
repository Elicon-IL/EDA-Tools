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

            var expected = new List<ModuleCount> {
                new ModuleCount("an2", 1135),new ModuleCount("an3", 446),new ModuleCount("an4", 158),
                new ModuleCount("aoi21", 50),new ModuleCount("aoi22", 4),new ModuleCount("aoi31", 11),
                new ModuleCount("b1", 153),new ModuleCount("bd", 25),new ModuleCount("cvdd", 11),
                new ModuleCount("cvss", 59),new ModuleCount("dspbrs", 560),new ModuleCount("i1", 1140),
                new ModuleCount("ic", 15),new ModuleCount("iobhc", 10),new ModuleCount("mx21", 1742),
                new ModuleCount("mx21i", 695),new ModuleCount("mx41", 142),new ModuleCount("na2", 265),
                new ModuleCount("na3", 19),new ModuleCount("na4", 7),new ModuleCount("no2", 86),
                new ModuleCount("no3", 42),new ModuleCount("no4", 8),new ModuleCount("oai21", 27),
                new ModuleCount("or2", 779),new ModuleCount("or3", 4),new ModuleCount("or4", 7),
                new ModuleCount("oth", 23),new ModuleCount("por", 1),new ModuleCount("xn2", 9),
                new ModuleCount("xo2", 605),new ModuleCount("oai22", 1),new ModuleCount("oai211", 1)
            };

            Assert.That(result, Is.EquivalentTo(expected));
        }
    }
 }