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

        public bool IsSatisfied(string statement)
        {
            return statement.FirstTokenIs(DefparamPrefix) ||
                   statement.FirstTokenIs(InitialPrefix) ||
                   statement.FirstTokenIs(TriPrefix) ||
                   statement.FirstTokenIs(Tri0Prefix) ||
                   statement.FirstTokenIs(Tri1Prefix) ||
                   statement.FirstTokenIs(TranPrefix);
        }
    }
}