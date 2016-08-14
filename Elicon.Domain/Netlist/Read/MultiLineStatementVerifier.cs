﻿using System.Linq;
using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.Read
{
    public interface IMultiLineStatementVerifier
    {
        bool IsMultiLineStatement(string statement);
    }

    public class MultiLineStatementVerifier : IMultiLineStatementVerifier
    {
        private readonly IStatementCriteria[] _multiLineStatementsComplementSet = {
            new EmptyStatementCriteria(), new EndModuleStatementCriteria()
        };
        
        public bool IsMultiLineStatement(string statement)
        {
            if (statement.EndsWith(";"))
                return false;

            return !InComplementSet(statement);
        }

        private bool InComplementSet(string statement)
        {
            return _multiLineStatementsComplementSet
                .Any(criteria => criteria.IsSatisfied(statement));
        }
    }
}