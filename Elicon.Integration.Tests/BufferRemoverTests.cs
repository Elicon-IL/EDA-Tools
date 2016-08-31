using System;
using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class BufferRemoverTests : IntegrationTestBase
    {
        private const string DummyNetlist = "MY-DUMMY-NETLIST";
        private INetlistRemover _netlistRemover;
        private IBufferRemover _target;
        

        [SetUp]
        public void SetUp()
        {
            _netlistRemover = Get<INetlistRemover>();
            Get<INetlistCloner>().Clone(ExampleNetlistFilePath, DummyNetlist);
            _target = Get<IBufferRemover>();            
        }

        [Test]
        public void Remove_PassThroughBuffer_NotRemoveBuffer()
        {
            
        }

        [Test]
        public void Remove_OneBuffer_RemoveBuffer()
        {

        }

        [Test]
        public void Remove_TwoBuffers_RemoveBuffers()
        {

        }

        [Test]
        public void Remove_ChainOfTwoBuffers_RemoveBuffers()
        {

        }



        [TearDown]
        public void TearDown()
        {
            Get<INetlistRemover>().Remove(DummyNetlist);
        }
    }
 }


