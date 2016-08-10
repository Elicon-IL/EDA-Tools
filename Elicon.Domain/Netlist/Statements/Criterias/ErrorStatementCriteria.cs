using Elicon.Framework;

namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class ErrorStatementCriteria : IStatementCriteria
    {
        private const string DefparamPrefix = "defparam";
        private const string InitialPrefix = "initial ";
        private const string TriPrefix = "tri";
        private const string Tri0Prefix = "tri0";
        private const string Tri1Prefix = "tri1";
        private const string TranPrefix = "tran";

        public bool IsSatisfied(string commnad)
        {
            return commnad.FirstTokenIs(DefparamPrefix) ||
                   commnad.FirstTokenIs(InitialPrefix) ||
                   commnad.FirstTokenIs(TriPrefix) ||
                   commnad.FirstTokenIs(Tri0Prefix) ||
                   commnad.FirstTokenIs(Tri1Prefix) ||
                   commnad.FirstTokenIs(TranPrefix);
        }
    }
}