using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.RemoveBuffer
{
    public interface IRemoveBufferManipulation
    {
        void Remove(RemoveBufferRequest removeBufferRequest);
    }

    public interface INetlistFileContentDirector
    {
        string Construct(string source);
    }

    public class RemoveBufferManipulation : IRemoveBufferManipulation
    {
        private readonly INetlistCloner _netlistCloner;
        private readonly IFileWriter _fileWriter;
        private readonly IBufferRemover _bufferRemover;
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly INetlistFileContentDirector _netlistFileContentDirector;

        public RemoveBufferManipulation(INetlistCloner netlistCloner, IFileWriter fileWriter, IBufferRemover bufferRemover, INetlistDataBuilder netlistDataBuilder, INetlistFileContentDirector netlistFileContentDirector)
        {
            _netlistCloner = netlistCloner;
            _fileWriter = fileWriter;
            _bufferRemover = bufferRemover;
            _netlistDataBuilder = netlistDataBuilder;
            _netlistFileContentDirector = netlistFileContentDirector;
        }

        public void Remove(RemoveBufferRequest removeBufferRequest)
        {
            _netlistDataBuilder.Build(removeBufferRequest.SourceNetlist);
            _netlistCloner.Clone(removeBufferRequest.SourceNetlist, removeBufferRequest.TargetNetlist);

            _bufferRemover.Remove(removeBufferRequest.TargetNetlist, removeBufferRequest.BufferName, removeBufferRequest.InputPort, removeBufferRequest.OutputPort);

            var content = _netlistFileContentDirector.Construct(removeBufferRequest.TargetNetlist);
            _fileWriter.Write(removeBufferRequest.TargetNetlist, "Remove Buffers", content);
        }
    }
}
