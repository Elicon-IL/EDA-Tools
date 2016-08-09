namespace Elicon.Domain.Netlist.Commands.Criterias
{
    public class EndModuleCommandCriteria : ICommandCriteria
    {
        public bool IsSatisfied(string commnad)
        {
            return commnad.Equals("endmodule");
        }
    }
}