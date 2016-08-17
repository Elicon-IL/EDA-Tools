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
            var expected = new Dictionary<string, int> {
                {"an2", 85},{"an3", 14},{"an4", 30},{"aoi21", 54},{"aoi22", 15},{"aoi31", 20},{"b1", 1},
                {"cvss", 2},{"dpb", 3},{"dpbr", 77},{"dpbs", 2},{"dspbr", 489},{"dspbs", 51},{"i1", 903},
                {"ioblc", 20},{"mx21", 153},{"mx21i", 40},{"na2", 89},{"na3", 16},{"na4", 8},{"no2", 183},
                {"no3", 45},{"no4", 16},{"oai21", 29},{"oai211", 11},{"oai22", 2},{"oai31", 2},{"or2", 47},
                {"or3", 37},{"or4", 8},{"x_and2", 22},{"x_buf", 5526},{"x_buf_inp", 17},{"x_bufgmux", 6},
                {"x_inv", 30},{"x_latche", 2},{"x_mux2", 234},{"x_obuf", 37},{"x_obuft", 3},{"x_one", 13},
                {"x_pu", 1},{"x_ramd16", 192},{"x_xor2", 74},{"x_zero", 25},{"xn2", 21},{"xo2", 98}
            };

            var result = _target.CountNativeCells(ExampleNetlistFilePath, ExampleNetlistTopModule);

            Assert.That(result, Is.EquivalentTo(expected));
        }
    }
}