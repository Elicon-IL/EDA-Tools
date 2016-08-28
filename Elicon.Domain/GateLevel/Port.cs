namespace Elicon.Domain.GateLevel
{
    public class Port
    {
        public Port(string portName, PortType portType = PortType.Inout)
        {
            PortName = portName;
            PortType = portType;
        }

        public string PortName { get; set; }
        public PortType PortType { get; set; }
    }

    public enum PortType
    {
        Inout = 0,
        Input,
        Output
    }
}