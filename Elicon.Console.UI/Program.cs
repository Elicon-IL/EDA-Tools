using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Elicon.Console.Config;
using Elicon.Domain;

namespace Elicon.Console.UI
{
    class Program
    {
        static void Main(string[] args)
        {
            //Bootstrapper.Boot(new Assembly[0]);
            
//
//            System.Console.WriteLine("Please enter netlist file path");
//            var source = System.Console.ReadLine();
//
//            var report = Bootstrapper.Get<ICountLibraryGatesReport>();
//            var orderedCells = report.CountLibraryGates(source, "patgen_rtl").OrderBy(kvp => kvp.Key);
//            
//            foreach (var kvp in orderedCells)
//                System.Console.WriteLine(($"Cell = {kvp.Key}, count = {kvp.Value}"));

            //            var report = Bootstrapper.Get<IPhysicalModulePathReport>();
            //
            //            var result = report.GetPhysicalPaths("D:\\nlp.v", "y3_asic", new List<string>() { "x_lut4_0x0000" });
            //            foreach (var path in result["x_lut4_0x0000"])
            //                System.Console.WriteLine(path);

            System.Console.ReadLine();
        }
    }
}

