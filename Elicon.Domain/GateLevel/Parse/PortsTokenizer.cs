namespace Elicon.Domain.GateLevel.Parse
{
    public class PortsTokenizer
    {
        private const char BackslashChar = '\\';
        private const char SpaceChar = ' ';
        private const char CommaChar = ',';
        private const char DotChar = '.';
        private const char TabChar = '\t';
        private const char LeftRoundBracketChar = '(';
        private const char RightRoundBracketChar = ')';
        private const char LeftCurlyBracketChar = '{';
        private const char RightCurlyBracketChar = '}';

        public bool HasNext(PortsTokenizeRequest request)
        {
            return request.StringPosition < request.MaxLen;
        }

        public string NextToken(PortsTokenizeRequest request)
        {
            while (HasNext(request))
            {
                switch (request.TrimmedStatement[request.StringPosition])
                {
                    case TabChar:
                    case SpaceChar:
                    case CommaChar:
                    case DotChar:
                        // Just skip these chars.
                        request.StringPosition++;
                        break;
                    default:
                    {
                        request.InEscape = false;
                        request.StartPos = request.StringPosition;
                        request.EscapePos = request.StringPosition;
                        if (request.PortDone || request.IsPortList)
                        {
                            if (request.TrimmedStatement[request.StringPosition] == LeftRoundBracketChar)
                            {
                                // Wire / port name starts after this bracket.
                                request.StringPosition++;
                                // Skip leading spaces (if any).
                                while (HasNext(request) && request.TrimmedStatement[request.StringPosition] == ' ')
                                    request.StringPosition++;
                                request.EscapePos = request.StringPosition;
                                request.StartPos = request.StringPosition;
                            }
                            else
                            {
                                if (!request.IsPortList)
                                {
                                    // Skip all chars before the wire name bracket.
                                    request.StringPosition++;
                                    continue;
                                }
                            }

                            // Parse loop for the wire / port name.
                            request.InBus = false;
                            while (HasNext(request))
                            {
                                if (request.InEscape)
                                {
                                    if (request.TrimmedStatement[request.StringPosition] == SpaceChar)
                                    {
                                        request.InEscape = false;
                                        request.StringPosition++;
                                    }
                                    else
                                        request.StringPosition++;
                                }
                                else if (request.InBus)
                                {
                                    switch (request.TrimmedStatement[request.StringPosition])
                                    {
                                        case BackslashChar:
                                            // Must be the first char to be legal.
                                            if (request.EscapePos == request.StringPosition)
                                                request.InEscape = true;
                                            break;
                                        case RightCurlyBracketChar:
                                            request.InBus = false;
                                            break;
                                        case CommaChar:
                                        case SpaceChar:
                                            // Escape is legal after these chars.
                                            request.EscapePos = request.StringPosition + 1;
                                            break;
                                    }
                                    request.StringPosition++;
                                }
                                else
                                {
                                    switch (request.TrimmedStatement[request.StringPosition])
                                    {
                                        case BackslashChar:
                                            // Must be the first char to be legal.    
                                            if (request.StringPosition == request.EscapePos)
                                                request.InEscape = true;
                                            request.StringPosition++;
                                            break;
                                        case RightRoundBracketChar:
                                            request.PortDone = false;
                                            request.StringPosition++;
                                            return request.TrimmedStatement.Substring(request.StartPos, request.StringPosition - 1 - request.StartPos).Trim();
                                        case CommaChar:
                                            request.StringPosition++;
                                            if (request.IsPortList)
                                                return request.TrimmedStatement.Substring(request.StartPos, request.StringPosition - 1 - request.StartPos).Trim();
                                            break;
                                        case LeftCurlyBracketChar:
                                            request.InBus = true;
                                            request.StringPosition++;
                                            break;
                                        default:
                                            request.StringPosition++;
                                            break;
                                    }
                                }
                            }
                        }
                        else
                        {
                            request.EscapePos = request.StringPosition;
                            // Parse loop for the port name.
                            while (HasNext(request))
                            {
                                // Exit if port was done.
                                if (request.PortDone)
                                    break;
                                if (request.InEscape)
                                {
                                    if (request.TrimmedStatement[request.StringPosition] == SpaceChar)
                                    {
                                        request.InEscape = false;
                                        request.PortDone = true;
                                        return request.TrimmedStatement.Substring(request.StartPos, request.StringPosition - request.StartPos).Trim();
                                    }
                                    request.StringPosition++;
                                }
                                else
                                {
                                    switch (request.TrimmedStatement[request.StringPosition])
                                    {
                                        case BackslashChar:
                                            // Must be the first char to be legal.
                                            if (request.StringPosition == request.EscapePos)
                                                request.InEscape = true;
                                            request.StringPosition++;
                                            break;
                                        case SpaceChar:
                                        case LeftRoundBracketChar:
                                            request.PortDone = true;
                                            return request.TrimmedStatement.Substring(request.StartPos, request.StringPosition - request.StartPos).Trim();
                                        default:
                                            request.StringPosition++;
                                            break;
                                    }
                                }
                            }
                        }
                    }
                    break;
                }
            }
            if (!request.IsPortList)
                return null;
            if (request.StringPosition <= request.StartPos)
                return null;

            return request.TrimmedStatement.Substring(request.StartPos, request.StringPosition - request.StartPos).Trim();
        }
    }
}