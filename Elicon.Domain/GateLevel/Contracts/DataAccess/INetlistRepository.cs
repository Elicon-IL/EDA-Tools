using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface INetlistRepository
    {
        void Add(Netlist netlist);
        Netlist Get(string source);
        IList<Netlist> GetAll();
        void Update(Netlist netlist);
        void Remove(string source);
        bool Exists(string source);
    }
}