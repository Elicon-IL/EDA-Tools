using System.Collections.Generic;
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
            var net = new List<PortWirePair>();
            if (statement.GetHashCode() % 3 == 0)
                net.Add(new PortWirePair("z", "ebra"));
            else if (statement.GetHashCode() % 3 == 1)
                net.Add(new PortWirePair("b", "ird"));

            return net;
        }
    }
}