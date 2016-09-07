namespace Elicon.Domain.GateLevel
{
    public interface IFileWriteRequest
    {
        string Destination { get; set; }
        string Action { get; set; }
    }
}