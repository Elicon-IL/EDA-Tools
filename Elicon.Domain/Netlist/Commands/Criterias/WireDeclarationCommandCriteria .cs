using Elicon.Framework;

namespace Elicon.Domain.Netlist.Commands.Criterias
{
    public class WireDeclarationCommandCriteria : ICommandCriteria
    {
        private const string WireKeyWord = "wire";

        public bool IsSatisfied(string commnad)
        {
            return commnad.FirstTokenIs(WireKeyWord);
        }

        public CommandType CommandType => CommandType.WireDeclaration;
    }
}