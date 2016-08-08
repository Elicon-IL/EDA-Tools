namespace Elicon.Domain.Netlist.Commands.Criterias
{
    public class ErrorLineCommandCriteria : ICommandCriteria
    {
        private const string DefparamPrefix = "defparam ";
        private const string InitialPrefix = "initial ";
        private const string TriPrefix = "tri ";
        private const string Tri0Prefix = "tri0 ";
        private const string Tri1Prefix = "tri1 ";
        private const string TranPrefix = "tran ";

        public bool IsSatisfied(string commnad)
        {
            return commnad.StartsWith(DefparamPrefix) ||
                   commnad.StartsWith(InitialPrefix) ||
                   commnad.StartsWith(TriPrefix) ||
                   commnad.StartsWith(Tri0Prefix) ||
                   commnad.StartsWith(Tri1Prefix) ||
                   commnad.StartsWith(TranPrefix);
        }

        public CommandType CommandType => CommandType.Error;
    }
}