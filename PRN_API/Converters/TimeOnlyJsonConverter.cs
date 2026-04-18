using System.Text.Json;
using System.Text.Json.Serialization;

namespace PRN_API.Converters
{
    public class TimeOnlyJsonConverter : JsonConverter<TimeOnly>
    {
        private const string Format = "HH:mm:ss";

        public override TimeOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            var value = reader.GetString();
            if (string.IsNullOrEmpty(value))
                return default;

            // Support both "HH:mm" and "HH:mm:ss" formats
            if (TimeOnly.TryParseExact(value, "HH:mm:ss", out var result))
                return result;
            if (TimeOnly.TryParseExact(value, "HH:mm", out result))
                return result;
            if (TimeOnly.TryParse(value, out result))
                return result;

            throw new JsonException($"Cannot convert \"{value}\" to TimeOnly.");
        }

        public override void Write(Utf8JsonWriter writer, TimeOnly value, JsonSerializerOptions options)
        {
            writer.WriteStringValue(value.ToString(Format));
        }
    }
}
