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
    }
}