namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface IManipultaionRequest
    {
        string SourceNetlist { get; set; }
        string TargetNetlist { get; set; }
    }
}