using System;

namespace Elicon.Framework
{
    public static class StringExtensions
    {
        public static bool FirstTokenIs(this string str, string token)
        {
            if (!str.StartsWith(token))
                return false;

            return str.Length == token.Length
                || str[token.Length] == ' '
                || str[token.Length] == '\t';
        }

        public static bool IsNullOrEmpty(this string str)
        {
            return string.IsNullOrEmpty(str);
        }

        public static bool IsEscaped(this string str)
        {
            return str.StartsWith("\\");
        }

        public static string RemoveLastChar(this string str)
        {
            return str.Substring(0, str.Length - 1).Trim();
        }

        public static string RemoveFirstChar(this string str)
        {
            return str.Substring(1).Trim();
        }

        public static string KeepUntilFirstExclusive(this string str, string delimiter)
        {
            return str.Substring(0, str.IndexOf(delimiter, StringComparison.Ordinal)).Trim();
        }

        public static string KeepUntilLastExclusive(this string str, string delimiter)
        {
            return str.Substring(0, str.LastIndexOf(delimiter, StringComparison.Ordinal)).Trim();
        }

        public static string KeepFromFirstInclusive(this string str, string delimiter)
        {
            return str
               .Substring(str.IndexOf(delimiter, StringComparison.Ordinal))
               .Trim();
        }

        public static string KeepUntilFirstExclusive(this string str, char delimiter)
        {
            return str.KeepUntilFirstExclusive(delimiter.ToString());
        }

        public static string KeepUntilLastExclusive(this string str, char delimiter)
        {
            return str.KeepUntilLastExclusive(delimiter.ToString());
        }

        public static string KeepFromFirstInclusive(this string str, char delimiter)
        {
            return str.KeepFromFirstInclusive(delimiter.ToString());
        }
    }
}
