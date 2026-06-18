// 02_runes_and_strings.v
// This demo file explains strings and runes, highlighting V's UTF-8 design and byte indexing.

fn main() {
	println("=== 2. Runes & Strings ===")

	// 1. Strings
	// Strings in V are immutable, UTF-8 encoded byte sequences.
	// You can use single quotes or double quotes.
	str := "Hello, V!"
	println("String: ${str}")

	// 2. Runes (Unicode Code Points)
	// A rune represents a single Unicode character and is declared using backticks (`` ` ``).
	// Runes are represented internally as 32-bit integers (u32/rune).
	r := `🚀`
	println("Rune literal: `🚀`")
	println("Rune numerical value (Unicode code point): ${r}") // prints the code point integer
	println("Rune converted back to string: " + r.str())     // converts to string to print representation

	// 3. The UTF-8 Gotcha: Bytes vs Characters (Runes)
	// Because strings are UTF-8 encoded byte sequences, `.len` returns the length in BYTES, not characters.
	// Indexing strings with `[index]` returns a BYTE (u8), not a character.
	emoji_str := "Hi 👋" // '👋' takes 4 bytes in UTF-8
	println("String: '${emoji_str}'")
	println("Byte length (.len): ${emoji_str.len}") // Output will be 7 (2 bytes for 'Hi', 1 for space, 4 for '👋')

	// Indexing returns a byte:
	first_byte := emoji_str[0]
	println("First byte (ASCII code for 'H'): ${first_byte} (character: ${first_byte.ascii_str()})")

	// 4. Safe Unicode Traversal using .runes()
	// To iterate over characters (runes) instead of raw bytes, use the `.runes()` method.
	runes := emoji_str.runes()
	println("Rune count: ${runes.len}") // Output will be 4 ('H', 'i', ' ', '👋')
	
	println("Iterating over runes:")
	for item in runes {
		println("  Rune: ${item.str()} (Code Point: ${item})")
	}
}
