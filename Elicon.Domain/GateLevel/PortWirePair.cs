namespace Elicon.Domain.GateLevel
{
    public class PortWirePair
    {
        public PortWirePair(string port, string wire)
        {
            Port = port;
            Wire = wire;
        }

        public string Port { get; set; } // ToDo This should be Port Object In Future versions
        public string Wire { get; set; }
    }
}