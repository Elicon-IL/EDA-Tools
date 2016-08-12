namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class EndModuleStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string statement)
        {
            return statement.Equals("endmodule");
        }
    }
}