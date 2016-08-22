using System;
using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.Netlist.Parse
{
    public class InstanceStatementParser
    {
        public string GetModuleName(string statement)
        {
            return statement
                .KeepUntilFirst(' ');
        }

        public string GeInstanceName(string statement)
        {
            statement = statement.KeepFromFirst(' ');
            if (statement.IsEscaped())
                return statement.KeepUntilFirst(' ');

            return statement.KeepUntilFirst('(');
        }

        public IList<PortWirePair> GetNet(string statement)
        {
            var connections = SplitConnections(GetWiringPartFrom(statement));
            return connections.Select(ParsePortWirePair).ToList();
        }

        private IEnumerable<string> SplitConnections(string instanceConnections)
        {
            var connectionsList = new List<string>();
            var stringPosition = 0;
            var maxLen = instanceConnections.Length;

            // Start looping on the instance connection string chars.
            while (stringPosition < maxLen)
            {
                switch (instanceConnections[stringPosition])
                {
                    case '\t':
                    case ' ':
                    case ',':
                        // Just skip.
                        stringPosition++;
                        break;
                    case '.':
                        {
                            stringPosition++;
                            // Parse loop for extracting the port(wire) connection.
                            var inEscape = false;
                            var inBus = false;
                            var exitDo = false;
                            var escapePos = stringPosition;
                            var startPos = stringPosition;
                            while ((stringPosition < maxLen) && (exitDo == false))
                            {
                                if (inEscape)
                                {
                                    if (instanceConnections[stringPosition] == ' ')
                                        inEscape = false;
                                    stringPosition++;
                                }
                                else if (inBus)
                                {
                                    switch (instanceConnections[stringPosition])
                                    {
                                        case '\\':
                                            // Must be the first char to be legal.
                                            if (escapePos == stringPosition)
                                                inEscape = true;
                                            break;
                                        case '}':
                                            inBus = false;
                                            break;
                                        case ',':
                                        case ' ':
                                            // Escape is legal after these chars.
                                            escapePos = stringPosition + 1;
                                            break;
                                    }
                                    stringPosition++;
                                }
                                else
                                {
                                    switch (instanceConnections[stringPosition])
                                    {
                                        case '\\':
                                            // Must be the first char to be legal.
                                            if (escapePos == stringPosition)
                                                inEscape = true;
                                            stringPosition++;
                                            break;
                                        case '(':
                                        case ' ':
                                            // Escape is legal after these chars.
                                            stringPosition++;
                                            escapePos = stringPosition;
                                            break;
                                        case ')':
                                            stringPosition++;
                                            exitDo = true;
                                            break;
                                        case '{':
                                            inBus = true;
                                            stringPosition++;
                                            escapePos = stringPosition;
                                            break;
                                        default:
                                            stringPosition++;
                                            break;
                                    }
                                }
                            }
                            // Add the token we found to the list.
                            connectionsList.Add(instanceConnections.Substring(startPos, stringPosition - startPos));
                        }
                        break;
                    default:
                        // ERROR in wiring - just skip this char.
                        stringPosition++;
                        break;
                }
            }
            return connectionsList;
        }

        private PortWirePair ParsePortWirePair(string portAndWire)
        {
            string portName = null;
            string wireName = null;
            var portDone = false;
            var stringPosition = 0;
            var maxLen = portAndWire.Length;

            while (stringPosition < maxLen)
            {
                switch (portAndWire[stringPosition])
                {
                    case '\t':
                    case ' ':
                    case '.':
                        // Just skip.
                        stringPosition++;
                        break;
                    default:
                        {
                            var inEscape = false;
                            var startPos = stringPosition;
                            int escapePos;
                            if (portDone)
                            {
                                if (portAndWire[stringPosition] == '(')
                                {
                                    // Wire name starts after this bracket.
                                    stringPosition++;
                                    // Skip leading spaces (if any).
                                    while (portAndWire[stringPosition] == ' ')
                                        stringPosition++;
                                    escapePos = stringPosition;
                                    startPos = stringPosition;
                                }
                                else
                                {
                                    // Skip all chars before the wire name bracket.
                                    stringPosition++;
                                    continue;
                                }

                                // Parse loop for the wire name.
                                var inBus = false;
                                while (stringPosition < maxLen)
                                {
                                    if (inEscape)
                                    {
                                        if (portAndWire[stringPosition] == ' ')
                                        {
                                            inEscape = false;
                                            stringPosition++;
                                        }
                                        else
                                            stringPosition++;
                                    }
                                    else if (inBus)
                                    {
                                        switch (portAndWire[stringPosition])
                                        {
                                            case '\\':
                                                // Must be the first char to be legal.
                                                if (escapePos == stringPosition)
                                                    inEscape = true;
                                                break;
                                            case '}':
                                                inBus = false;
                                                break;
                                            case ',':
                                            case ' ':
                                                // Escape is legal after these chars.
                                                escapePos = stringPosition + 1;
                                                break;
                                        }
                                        stringPosition++;
                                    }
                                    else
                                    {
                                        switch (portAndWire[stringPosition])
                                        {
                                            case '\\':
                                                // Must be the first char to be legal.    
                                                if (stringPosition == escapePos)
                                                    inEscape = true;
                                                stringPosition++;
                                                break;
                                            case ' ':
                                            case ')':
                                                wireName = portAndWire.Substring(startPos, stringPosition - startPos);
                                                // Parsing done - force exit.
                                                stringPosition = maxLen;
                                                break;
                                            case '{':
                                                inBus = true;
                                                stringPosition++;
                                                break;
                                            default:
                                                stringPosition++;
                                                break;
                                        }
                                    }
                                }
                            }
                            else
                            {
                                escapePos = stringPosition;
                                // Parse loop for the port name.
                                while (stringPosition < maxLen)
                                {
                                    // Exit if port was done.
                                    if (portDone)
                                        break;
                                    if (inEscape)
                                    {
                                        if (portAndWire[stringPosition] == ' ')
                                        {
                                            inEscape = false;
                                            portName = portAndWire.Substring(startPos, stringPosition - startPos);
                                            portDone = true;
                                        }
                                        stringPosition++;
                                    }
                                    else
                                    {
                                        switch (portAndWire[stringPosition])
                                        {
                                            case '\\':
                                                // Must be the first char to be legal.
                                                if (stringPosition == escapePos)
                                                    inEscape = true;
                                                stringPosition++;
                                                break;
                                            case ' ':
                                            case '(':
                                                portName = portAndWire.Substring(startPos, stringPosition - startPos);
                                                portDone = true;
                                                // Let wire loop start with these chars.
                                                break;
                                            default:
                                                stringPosition++;
                                                break;
                                        }
                                    }
                                }
                            }
                        }
                        break;
                }
            }
            return new PortWirePair(portName, wireName);
        }

        private string GetWiringPartFrom(string line)
        {
            line = line.Trim();
            // Remove cell name token.
            line = line.Substring(line.IndexOf(" ", StringComparison.Ordinal)).Trim();
            // Remove instance name token only if it is escaped (because then it might contains '(')
            if (line.IsEscaped())
                line = line.Substring(line.IndexOf(" ", StringComparison.Ordinal)).Trim();
            // Return the contents of the wrapping round brackets.
            line = line.Substring(line.IndexOf("(", StringComparison.Ordinal) + 1).Trim();
            return line.Substring(0, line.LastIndexOf(")", StringComparison.Ordinal)).Trim();
        }
    }
}