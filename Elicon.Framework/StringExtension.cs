namespace Elicon.Framework
{
    public static class StringExtension
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
    }

}
