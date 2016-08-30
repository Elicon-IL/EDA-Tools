using System;
using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.RemoveBuffer
{
    public interface IRemoveBufferManipulation
    {
        void Remove(RemoveBufferRequest removeBufferRequest);
    }

    public interface IBufferRemover
    {
        void Remove(string netlist, string bufferName, string inputPort, string outputPort);
    }

    public class BufferRemover : IBufferRemover
    {
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceRepository _instanceRepository;

        public BufferRemover(IModuleRepository moduleRepository, IInstanceRepository instanceRepository)
        {
            _moduleRepository = moduleRepository;
            _instanceRepository = instanceRepository;
        }

        public void Remove(string netlist, string bufferName, string inputPort, string outputPort)
        {
            var buffers = _instanceRepository.GetByModuleName(netlist, bufferName);

            foreach (var buffer in buffers)
            {
                var bufferInputWire = BufferInputWire(inputPort, buffer);
                var bufferOutputWire = BufferOutputWire(outputPort, buffer);
                var module = _moduleRepository.Get(netlist, buffer.HostModuleName);

                if (PassThroughBuffer(module, bufferInputWire, bufferOutputWire))
                    continue;

                if (BufferDrivesHostModuleOutputPort(module, bufferOutputWire))
                {
                    foreach (var instance in _instanceRepository.GetByHostModule(netlist, module.Name))
                        foreach (var pwp in instance.Net.Where(PortDrivesBuffer(bufferInputWire)))
                            pwp.Wire = bufferOutputWire;
                }
                else
                {
                    foreach (var instance in _instanceRepository.GetByHostModule(netlist, module.Name))
                        foreach (var pwp in instance.Net.Where(BufferDrivePort(bufferOutputWire)))
                            pwp.Wire = bufferInputWire;
                }

                _instanceRepository.Remove(buffer);
            }
        }

        private Func<PortWirePair, bool> PortDrivesBuffer(string bufferInputWire)
        {
            return pwp => pwp.Wire == bufferInputWire;
        }

        private bool PassThroughBuffer(Module module, string bufferInputWire, string bufferOutputWire)
        {
            return module.Ports.Any(p => p.PortName == bufferInputWire) 
                && module.Ports.Any(p => p.PortName == bufferOutputWire);
        }

        private string BufferOutputWire(string outputPort, Instance buffer)
        {
            return buffer.Net.Single(pwp => pwp.Port == outputPort).Wire;
        }

        private string BufferInputWire(string inputPort, Instance buffer)
        {
            return buffer.Net.Single(pwp => pwp.Port == inputPort).Wire;
        }

        private Func<PortWirePair, bool> BufferDrivePort(string bufferOutputWire)
        {
            return pwp => pwp.Wire == bufferOutputWire;
        }

        private static bool BufferDrivesHostModuleOutputPort(Module module, string bufferOutputWire)
        {
            return module.Ports.Any(p => p.PortName == bufferOutputWire);
        }
    }

    public class RemoveBufferRequest
    {
        public string Netlist { get; set; }
        public string NewNetlist { get; set; }
        public string BufferName { get; set; }
        public string InputPort { get; set; }
        public string OutputPort { get; set; }
    }

    public class RemoveBufferManipulation : IRemoveBufferManipulation
    {
        private readonly INetlistCloner _netlistCloner;
        private readonly INetlistFileWriter _netlistFileWriter;
        private readonly IBufferRemover _bufferRemover;

        public RemoveBufferManipulation(INetlistCloner netlistCloner, INetlistFileWriter netlistFileWriter, IBufferRemover bufferRemover)
        {
            _netlistCloner = netlistCloner;
            _netlistFileWriter = netlistFileWriter;
            _bufferRemover = bufferRemover;
        }

        public void Remove(RemoveBufferRequest removeBufferRequest)
        {
            _netlistCloner.Clone(removeBufferRequest.Netlist, removeBufferRequest.NewNetlist);

            _bufferRemover.Remove(removeBufferRequest.NewNetlist, removeBufferRequest.BufferName, removeBufferRequest.InputPort, removeBufferRequest.OutputPort);

            _netlistFileWriter.Write(removeBufferRequest.NewNetlist);
        }
    }
}
