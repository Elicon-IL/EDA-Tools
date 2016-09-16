using System.Collections.Generic;
using Elicon.Domain.GateLevel.Reports.CountLibraryGates;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class CountLibraryGatesQueryTests : IntegrationTestBase
    {
        private ICountLibraryGatesQuery _target;

        [SetUp]
        public void SetUp()
        {
            _target = Get<ICountLibraryGatesQuery>();
        }

        [Test]
        public void CountLibraryGates_NetlistWithLibraryGates_ReturnsAllLibraryGatesCount()
        {
            var result = _target.CountLibraryGates(ExampleNetlistFilePath, ExampleNetlistTopModule);

            var expected = new List<LibraryGateCount> {
                new LibraryGateCount("an2", 1135),new LibraryGateCount("an3", 446),new LibraryGateCount("an4", 158),
                new LibraryGateCount("aoi21", 50),new LibraryGateCount("aoi22", 4),new LibraryGateCount("aoi31", 11),
                new LibraryGateCount("b1", 153),new LibraryGateCount("bd", 25),new LibraryGateCount("cvdd", 11),
                new LibraryGateCount("cvss", 59),new LibraryGateCount("dspbrs", 560),new LibraryGateCount("i1", 1140),
                new LibraryGateCount("ic", 15),new LibraryGateCount("iobhc", 10),new LibraryGateCount("mx21", 1742),
                new LibraryGateCount("mx21i", 695),new LibraryGateCount("mx41", 142),new LibraryGateCount("na2", 265),
                new LibraryGateCount("na3", 19),new LibraryGateCount("na4", 7),new LibraryGateCount("no2", 86),
                new LibraryGateCount("no3", 42),new LibraryGateCount("no4", 8),new LibraryGateCount("oai21", 27),
                new LibraryGateCount("or2", 779),new LibraryGateCount("or3", 4),new LibraryGateCount("or4", 7),
                new LibraryGateCount("oth", 23),new LibraryGateCount("por", 1),new LibraryGateCount("xn2", 9),
                new LibraryGateCount("xo2", 605),new LibraryGateCount("oai22", 1),new LibraryGateCount("oai211", 1)
            };

            Assert.That(result, Is.EquivalentTo(expected));
        }
    }
 }