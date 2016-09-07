namespace Elicon.Domain.GateLevel.Reports
{
    public interface IFileWriteRequest
    {
        string Destination { get; set; }
        string Action { get; set; }
    }
}