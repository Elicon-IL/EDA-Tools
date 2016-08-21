namespace Elicon.Domain.Netlist
{
    public class PortWirePair
    {
        public PortWirePair(string port, string wire)
        {
            Port = port;
            Wire = wire;
        }

        public string Port { get; set; }
        public string Wire { get; set; }
    }
}