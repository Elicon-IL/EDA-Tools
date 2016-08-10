namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class EndModuleStatementCriteria : IStatementCriteria
    {
        public bool IsSatisfied(string commnad)
        {
            return commnad.Equals("endmodule");
        }
    }
}