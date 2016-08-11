using System.Collections.Generic;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.Domain.Netlist.DataQuery
{
    public interface INativeCellsCountQuery
    {
        IDictionary<string, long> Query(string moduleName);
    }

    public class NativeCellsCountQuery : INativeCellsCountQuery
    {
        private readonly IInstanceRepository _instanceRepository;

        public NativeCellsCountQuery(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }

        public IDictionary<string, long> Query(string moduleName)
        {
            var result = new Dictionary<string, long>();

            Count(moduleName, result);

            return result;
        }

        private void Count(string moduleName, Dictionary<string, long> cellsCount)
        {
            var instances = _instanceRepository.GetByModule(moduleName);
            foreach (var instance in instances)
            {
                if (instance.IsModule)
                    Count(instance.CellName, cellsCount);
                else
                    Increment(cellsCount, instance);
            }
        }

        private void Increment(Dictionary<string, long> cellsCount, Instance instance)
        {
            if (!cellsCount.ContainsKey(instance.CellName))
                cellsCount.Add(instance.CellName, 0);

            cellsCount[instance.CellName]++;
        }
    }
}