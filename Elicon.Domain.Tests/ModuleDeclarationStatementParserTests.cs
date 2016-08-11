﻿using Elicon.Domain.Netlist.Parse;
using Elicon.Domain.Netlist.Read;
using NUnit.Framework;

namespace Elicon.Domain.Tests
{
    [TestFixture]
    public class ModuleDeclarationStatementParserTests
    {
        private ModuleDeclarationStatementParser _target;

        [SetUp]
        public void SetUp()
        {
            _target = new ModuleDeclarationStatementParser();
        }

        [Test]
        [TestCase("module x_lut4_0x5500( i0, i3, o );")]
        [TestCase("module x_lut4_0x5500 ( i0, i3, o );")]
        public void GetModuleName_ModuleDeclarationStatement_ReturnsModuleName(string statement)
        {
            var result = _target.GetModuleName(statement);

            Assert.That(result, Is.EqualTo("x_lut4_0x5500"));
        }

        [Test]
        public void GetModuleName_ModuleDeclarationWithEscapedName_ReturnsModuleeName()
        {
            var statement = "no2 \\x_lut4_0x5500(08  ( .b(n36), .a(i0), .zn(o) );";

            var result = _target.GetModuleName(statement);

            Assert.That(result, Is.EqualTo("\\x_lut4_0x5500(08"));
        }
    }
}
