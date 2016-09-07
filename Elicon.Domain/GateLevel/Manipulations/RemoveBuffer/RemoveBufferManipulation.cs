using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.RemoveBuffer
{
    public interface IRemoveBufferManipulation
    {
        void Remove(RemoveBufferRequest removeBufferRequest);
    }

    public class RemoveBufferManipulation : IRemoveBufferManipulation
    {
        private readonly INetlistCloner _netlistCloner;
        private readonly INetlistFileWriter _netlistFileWriter;
        private readonly IBufferRemover _bufferRemover;
        private readonly INetlistDataBuilder _netlistDataBuilder;

        public RemoveBufferManipulation(INetlistCloner netlistCloner, INetlistFileWriter netlistFileWriter, IBufferRemover bufferRemover, INetlistDataBuilder netlistDataBuilder)
        {
            _netlistCloner = netlistCloner;
            _netlistFileWriter = netlistFileWriter;
            _bufferRemover = bufferRemover;
            _netlistDataBuilder = netlistDataBuilder;
        }

        public void Remove(RemoveBufferRequest removeBufferRequest)
        {
            _netlistDataBuilder.Build(removeBufferRequest.Netlist);
            _netlistCloner.Clone(removeBufferRequest.Netlist, removeBufferRequest.NewNetlist);

            _bufferRemover.Remove(removeBufferRequest.NewNetlist, removeBufferRequest.BufferName, removeBufferRequest.InputPort, removeBufferRequest.OutputPort);

            _netlistFileWriter.Write(removeBufferRequest.NewNetlist, "Remove Buffers");
        }
    }
}
