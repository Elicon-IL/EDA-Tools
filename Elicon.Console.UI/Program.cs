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

            System.Console.WriteLine("Please enter netlist file path");
            var source = System.Console.ReadLine();

            var report = Bootstrapper.Get<ICountNativeCellsReport>();
            var orderedCells = report.CountNativeCells(source).OrderBy(kvp => kvp.Key);

            foreach (var kvp in orderedCells)
                System.Console.WriteLine(($"Cell = {kvp.Key}, count = {kvp.Value}"));

            System.Console.ReadLine();
        }
    }
}

