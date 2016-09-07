namespace Elicon.Domain.GateLevel.Reports
{
    public interface IReportWriteRequest
    {
        string Destination { get; set; }
        string Action { get; }
    }
}