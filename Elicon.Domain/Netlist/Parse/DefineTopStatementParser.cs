using System;
using Elicon.Framework;

namespace Elicon.Domain.Netlist.Parse
{
    public class DefineTopStatementParser
    {
        public string GetTopModuleName(string statement)
        {
            return statement
                .KeepFromFirst(' ')
                .KeepFromFirst(' ');
        }
    }
}