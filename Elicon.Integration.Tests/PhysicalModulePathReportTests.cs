using System.Collections.Generic;
using Elicon.Domain.GateLevel.Reports.PhysicalModulePath;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class PhysicalModulePathReportTests : IntegrationTestBase
    {
        private IPhysicalModulePathReport _target;

        [SetUp]
        public void SetUp()
        {
            _target = Get<IPhysicalModulePathReport>();
        }

        [Test]
        public void GetPhysicalPaths_NetlistEx_ReturnsPhysicalPaths()
        {
            const string module = "x_lut4_0xff0c";
            const string anotherModule = "x_lut4_0x6a5f";
            var modulesToTrack = new List<string> { module, anotherModule };

            var result = _target.GetPhysicalPaths(ExampleNetlistFilePath, ExampleNetlistTopModule , modulesToTrack);

            var expected = new Dictionary<string, IList<string>> {
                { anotherModule, new List<string> { "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella1/tlib000001/tlib000062",
                    "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella1/tlib000001/tlib000063", "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella1/tlib000001/tlib000064",
                    "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella3/tlib000001/tlib000062", "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella3/tlib000001/tlib000063",
                    "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella3/tlib000001/tlib000064", "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella5/tlib000001/tlib000067",
                    "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella5/tlib000001/tlib000068", "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella5/tlib000001/tlib000069",
                    "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella5/tlib000001/tlib000070", "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella7/tlib000001/tlib000073",
                    "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella7/tlib000001/tlib000074", "CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella7/tlib000001/tlib000075"
                } },
                { module, new List<string> { "CDU/SCK_a1_I/tlib000001/tlib000004" } }
            };
            Assert.That(result.Count, Is.EqualTo(2));
            Assert.That(result[module], Is.EquivalentTo(expected[module]));
            Assert.That(result[anotherModule], Is.EquivalentTo(expected[anotherModule]));
        }
    }
}