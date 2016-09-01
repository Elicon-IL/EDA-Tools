using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Parse
{
    public class PortsDeclarationStatementParser
    {
        private readonly PortsParser _portsParser = new PortsParser();

        public PortType GetPortType(string trimmedStatement)
        {
            var type = trimmedStatement.KeepUntilFirstExclusiveAndTrim(' ');

            if (type == "input")
                return PortType.Input;
            if (type == "output")
                return PortType.Output;

            return PortType.Inout;
        }

        public IList<Port> GetPorts(string trimmedStatement)
        {
            trimmedStatement = trimmedStatement.KeepFromFirstInclusiveAndTrim(' ').RemoveLastCharAndTrim();
            return _portsParser.GetPorts(trimmedStatement).ToList();
        }
    }
}