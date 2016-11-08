using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Web.Script.Serialization;

namespace Elicon.Domain.GateLevel.Library
{

    public interface ILibraryLoader
    {
        void Load(string source);
    }

    public class LibraryLoader : ILibraryLoader
    {
        private readonly ILibraryRepository _libraryRepository;

        public LibraryLoader(ILibraryRepository libraryRepository)
        {
            _libraryRepository = libraryRepository;
        }

        public void Load(string sourcePath)
        {
            if (_libraryRepository.Exists(sourcePath))
                return;
            var jsonContents = File.ReadAllText(sourcePath);
            var deserializer = new JavaScriptSerializer();
            var libraryObject = deserializer.DeserializeObject(jsonContents);
            _libraryRepository.Add(sourcePath, new Library(CreateLibraryGates(libraryObject)));
        }

        private static Dictionary<string, LibraryGate> CreateLibraryGates(object libraryObject)
        {
            var gates = new Dictionary<string, LibraryGate>();
            var libraryGates = libraryObject as IEnumerable;
            if (libraryGates != null)
            {
                foreach (KeyValuePair<string, object> gateElement in libraryGates)
                {
                    var gateName = gateElement.Key;
                    var gateInfo = gateElement.Value as IEnumerable;
                    if (gateInfo != null)
                    {
                        var name = "";
                        var type = LibraryGateType.Uknown;
                        Dictionary<string, LibraryGatePortType> ports = null;
                        var size = 0;
                        foreach (KeyValuePair<string, object> info in gateInfo)
                        {
                            // NOTE: Key lookups and type-parsing are case-insensitive.
                            switch (info.Key.ToUpperInvariant())
                            {
                                case "NAME":
                                    name = (string) info.Value;
                                    break;
                                case "PORTSLIST":
                                    ports = ParsePorts(info.Value);
                                    break;
                                case "TYPE":
                                    type = ParseGateType((string) info.Value);
                                    break;
                                case "SIZE":
                                    size = (int)info.Value;
                                    break;
                            }
                        }
                        var gate = new LibraryGate(name, type, ports, size);
                        gates.Add(gateName, gate);
                    }
                }
            }
            return gates;
        }

        private static Dictionary<string, LibraryGatePortType> ParsePorts(object portsList)
        {
            var gatePorts = new Dictionary<string, LibraryGatePortType>();
            var ports = portsList as IEnumerable;
            if (ports != null)
            {
                foreach (Dictionary<string, object> port in ports)
                {
                    // NOTE: Key lookups and type-parsing are case-insensitive.
                    var portsDict = new Dictionary<string, object>(port, StringComparer.OrdinalIgnoreCase);
                    gatePorts.Add((string)portsDict["Name"], ParsePortType((string)portsDict["Type"]));
                }
            }
            return gatePorts;
        }

        private static LibraryGateType ParseGateType(string gateType)
        {
            LibraryGateType type;
            return Enum.TryParse(gateType, true, out type) ? type : LibraryGateType.Uknown;
        }

        private static LibraryGatePortType ParsePortType(string portType)
        {
            LibraryGatePortType type;
            return Enum.TryParse(portType, true, out type) ? type : LibraryGatePortType.UnDefined;
        }

    }

}
