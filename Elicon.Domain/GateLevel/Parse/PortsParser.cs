using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Parse
{
    public class PortsParser
    {
        public IList<Port> GetPorts(string ports)
        {
            if (ports.IsNullOrEmpty())
                return new List<Port>();

           return SplitPorts(ports).Select(s => new Port(s)).ToList();
        }

        private IEnumerable<string> SplitPorts(string ports)
        {
            var portsList = new List<string>();
            var stringPosition = 0;
            var maxLen = ports.Length;

            // Start looping on the string chars.
            while (stringPosition < maxLen)
            {
                switch (ports[stringPosition])
                {
                    case '\t':
                    case ' ':
                    case ',':
                        stringPosition++;
                        break;
                    default:
                        {
                            var inEscape = false;
                            var exitDo = false;
                            var escapePos = stringPosition;
                            var startPos = stringPosition;
                            while ((stringPosition < maxLen) && (exitDo == false))
                            {
                                if (inEscape)
                                {
                                    if (ports[stringPosition] == ' ')
                                    {
                                        exitDo = true;
                                        inEscape = false;
                                    }
                                    stringPosition++;
                                }
                                else
                                {
                                    switch (ports[stringPosition])
                                    {
                                        case '\\':
                                            // Must be the first char to be legal.
                                            if (escapePos == stringPosition)
                                                inEscape = true;
                                            stringPosition++;
                                            break;
                                        case ' ':
                                        case ',':
                                            exitDo = true;
                                            break;
                                        default:
                                            stringPosition++;
                                            break;
                                    }
                                }
                            }
                            // Add the token we found to the list.
                            portsList.Add(ports.Substring(startPos, stringPosition - startPos).Trim());
                            stringPosition++;
                        }
                        break;
                }
            }

            return portsList;
        }

    }
}