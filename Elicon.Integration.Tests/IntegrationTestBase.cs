using System;
using System.IO;
using System.Reflection;
using Elicon.Console.Config;
using Elicon.Domain.Netlist.Reports;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    public static class TestsFiles
    {               
        public static string ExampleNetlistFilePath = TestDllPath() + "\\example_netlist.v";

        private static string TestDllPath()
        {
            var dllDirName = Path.GetDirectoryName(Assembly.GetExecutingAssembly().CodeBase);
            var dllDirectory = new Uri(dllDirName).LocalPath;
            var pathAbove = Directory.GetParent(dllDirectory).FullName;
            return Directory.GetParent(pathAbove).FullName;
        }

    }

    public class IntegrationTestBase
    {
        static IntegrationTestBase() 
        {
            Bootstrapper.Boot();
        }

        public T Get<T>()
        {
            return Bootstrapper.Get<T>();
        }
    }

    [TestFixture]
    public class PrecentageCalculatorTests : IntegrationTestBase
    {
        private ICountNativeCellsReport _target;

        [SetUp]
        public void SetUp()
        {
            _target = Get<ICountNativeCellsReport>();
        }

        [Test]
        public void ClaculateProgression_ZeroProgression_ReturnsZero()
        {
            _target.CountNativeCells(TestsFiles.ExampleNetlistFilePath, "newpro");

//            Assert.That(result, Is.Zero);
        }

        
    }

    [TestFixture]
    public class PrecentageCaldculatorTests : IntegrationTestBase
    {
        private ICountNativeCellsReport _target;

        [SetUp]
        public void SetUp()
        {
            _target = Get<ICountNativeCellsReport>();
        }

        [Test]
        public void ClaculateProgression_ZeroProgression_ReturnsZero()
        {
            _target.CountNativeCells(TestsFiles.ExampleNetlistFilePath, "newpro");

            //            Assert.That(result, Is.Zero);
        }


    }
}

