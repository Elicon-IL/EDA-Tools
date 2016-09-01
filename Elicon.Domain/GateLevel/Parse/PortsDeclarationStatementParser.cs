using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Parse
{
    public class PortsDeclarationStatementParser
    {
        private readonly PortsParser _portsParser = new PortsParser();

        public PortType GetPortType(string statement)
        {
            var type = statement.KeepUntilFirstExclusiveAndTrim(' ');

            if (type == "input")
                return PortType.Input;
            if (type == "output")
                return PortType.Output;

            return PortType.Inout;
        }

        public IList<Port> GetPorts(string statement)
        {
            statement = statement.KeepFromFirstInclusiveAndTrim(' ').RemoveLastCharAndTrim();
            return _portsParser.GetPorts(statement).ToList();
        }
    }
}