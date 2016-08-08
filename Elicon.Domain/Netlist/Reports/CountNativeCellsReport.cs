﻿using System.Collections.Generic;
using Elicon.Domain.Netlist.BuildData;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.DataQuery;

namespace Elicon.Domain.Netlist.Reports
{
    public interface ICountNativeCellsReport
    {
        IDictionary<string, long> CountNativeCells(string source);
    }
        
    public class CountNativeCellsReport : ICountNativeCellsReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly INativeCellsCounter _nativeCellsCounter;
        private readonly IModuleRepository _moduleRepository;
        
        public CountNativeCellsReport(IModuleRepository moduleRepository, INativeCellsCounter nativeCellsCounter, INetlistDataBuilder netlistDataBuilder)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _moduleRepository = moduleRepository;
            _nativeCellsCounter = nativeCellsCounter;
        }

        public IDictionary<string, long> CountNativeCells(string source)
        {
            _netlistDataBuilder.Build(source);
            var top = _moduleRepository.GetTop();
            return _nativeCellsCounter.CountNativeCells(top.Name);
        }
    }
}

