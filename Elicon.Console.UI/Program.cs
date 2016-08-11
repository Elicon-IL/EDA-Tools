﻿using System.Collections.Generic;
using System.Linq;
using Elicon.Console.Config;
using Elicon.Domain.Netlist.Reports;

namespace Elicon.Console.UI
{
    class Program
    {
        static void Main(string[] args)
        {
            Bootstrapper.Boot();

//            System.Console.WriteLine("Please enter netlist file path");
//            var source = System.Console.ReadLine();

//            var report = Bootstrapper.Get<ICountNativeCellsReport>();
//            var orderedCells = report.CountNativeCells(source).OrderBy(kvp => kvp.Key);
//
//            foreach (var kvp in orderedCells)
//                System.Console.WriteLine(($"Cell = {kvp.Key}, count = {kvp.Value}"));

            var report = Bootstrapper.Get<IPhysicalModulePathReport>();

            var result = report.Query("D:\\nlp.v", new List<string>() { "x_lut4_0x0000" });
            foreach (var path in result["x_lut4_0x0000"])
                System.Console.WriteLine(path);

            System.Console.ReadLine();
        }
    }
}
