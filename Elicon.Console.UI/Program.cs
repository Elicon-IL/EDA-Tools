using Elicon.Console.Config;
using Elicon.Domain.Netlist.Reports;

namespace Elicon.Console.UI
{
    class Program
    {
        static void Main(string[] args)
        {
            Bootstrapper.Boot();

            var report = Bootstrapper.Get<ICountNativeCellsReport>();
            report.CountNativeCells("D:\\SoftwareProjects\\Netlist Util Tachzuka\\Count_Native_Cells\\nl.V");
        }
    }
}
