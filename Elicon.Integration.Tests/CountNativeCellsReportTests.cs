using System.Collections.Generic;
using Elicon.Domain.Netlist.Reports;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class CountNativeCellsReportTests : IntegrationTestBase
    {
        private ICountNativeCellsReport _target;

        [SetUp]
        public void SetUp()
        {
            _target = Get<ICountNativeCellsReport>();
        }

        [Test]
        public void CountNativeCells_NetlistWithNativeCells_ReturnsAllNativeCellsCount()
        {
            var result = _target.CountNativeCells(ExampleNetlistFilePath, ExampleNetlistTopModule);

            var expected = new Dictionary<string, int> {
                {"an2", 1135}, {"an3", 446}, {"an4", 158}, {"aoi21", 50}, {"aoi22", 4}, {"aoi31", 11}, {"b1", 153},
                {"bd", 25}, {"cvdd", 11}, {"cvss", 59}, {"dspbrs", 560}, {"i1", 1140}, {"ic", 15}, {"iobhc", 10},
                {"mx21", 1742}, {"mx21i", 695}, {"mx41", 142}, {"na2", 265}, {"na3", 19}, {"na4", 7}, {"no2", 86},
                {"no3", 42}, {"no4", 8}, {"oai21", 27}, {"oai211", 1}, {"oai22", 1}, {"or2", 779}, {"or3", 4},
                {"or4", 7}, {"oth", 23}, {"por", 1}, {"xn2", 9}, {"xo2", 605}
            };
            Assert.That(result, Is.EquivalentTo(expected));
        }
    }
}