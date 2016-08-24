using System;
using System.IO;
using System.Reflection;
using Elicon.Console.Config;
using Elicon.Domain.GateLevel.BuildData;

namespace Elicon.Integration.Tests
{
    public class IntegrationTestBase
    {
        public static string ExampleNetlistFilePath = TestDllPath() + "\\example_netlist.v";
        public static string ExampleNetlistTopModule = "cdu";

        static IntegrationTestBase() 
        {
            Bootstrapper.Boot();
            Bootstrapper.Get<INetlistDataBuilder>().Build(ExampleNetlistFilePath);
        }

        public T Get<T>()
        {
            return Bootstrapper.Get<T>();
        }
        
        private static string TestDllPath()
        {
            var dllDirName = Path.GetDirectoryName(Assembly.GetExecutingAssembly().CodeBase);
            var dllDirectory = new Uri(dllDirName).LocalPath;
            var pathAbove = Directory.GetParent(dllDirectory).FullName;
            return Directory.GetParent(pathAbove).FullName;
        }
    }
}

