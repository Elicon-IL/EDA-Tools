﻿namespace Elicon.Domain.GateLevel.Contracts.DataAccess
{
    public interface IFileWriter
    {
        void Write(IFileWriteRequest fileWriteRequest);
        void Write(string dest, string action, string content);
    }
}