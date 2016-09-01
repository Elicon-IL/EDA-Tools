using System;

namespace Elicon.Framework
{
    public static class StringExtensions
    {
        public static bool FirstTokenIs(this string target, string token)
        {
            if (!target.StartsWith(token))
                return false;

            return target.Length == token.Length
                || target[token.Length] == ' '
                || target[token.Length] == '\t';
        }

        public static bool IsNullOrEmpty(this string target)
        {
            return string.IsNullOrEmpty(target);
        }

        public static bool IsEscaped(this string target)
        {
            return target.StartsWith("\\");
        }

        public static string RemoveLastCharAndTrim(this string target)
        {
            if (target.IsNullOrEmpty())
                return target;

            return target.Substring(0, target.Length - 1).Trim();
        }

        public static string RemoveFirstCharAndTrim(this string target)
        {
            if (target.IsNullOrEmpty())
                return target;

            return target.Substring(1).Trim();
        }

        public static string KeepUntilFirstExclusiveAndTrim(this string target, string delimiter)
        {
            if (target.IsNullOrEmpty())
                return target;

            var delimiterIndex = target.IndexOf(delimiter, StringComparison.Ordinal);
            if (delimiterIndex == -1)
                return target;
            
            return target.Substring(0, delimiterIndex).Trim();
        }

        public static string KeepUntilLastExclusiveAndTrim(this string target, string delimiter)
        {
            if (target.IsNullOrEmpty())
                return target;

            var lastIndexOfDelimiter = target.LastIndexOf(delimiter, StringComparison.Ordinal);
            if (lastIndexOfDelimiter == -1)
                return target;

            return target.Substring(0, lastIndexOfDelimiter).Trim();
        }

        public static string KeepFromFirstInclusiveAndTrim(this string target, string delimiter)
        {
            if (target.IsNullOrEmpty())
                return target;

            var delimiterIndex = target.IndexOf(delimiter, StringComparison.Ordinal);
            if (delimiterIndex == -1)
                return target;

            return target
               .Substring(delimiterIndex)
               .Trim();
        }

        public static string KeepUntilFirstExclusiveAndTrim(this string target, char delimiter)
        {
            return target.KeepUntilFirstExclusiveAndTrim(delimiter.ToString());
        }

        public static string KeepUntilLastExclusiveAndTrim(this string target, char delimiter)
        {
            return target.KeepUntilLastExclusiveAndTrim(delimiter.ToString());
        }

        public static string KeepFromFirstInclusiveAndTrim(this string target, char delimiter)
        {
            return target.KeepFromFirstInclusiveAndTrim(delimiter.ToString());
        }
    }
}
