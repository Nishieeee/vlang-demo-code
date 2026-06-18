// 01_variables_mutability.v
// This demo file explains V's variable declarations and immutability by default.

fn main() {
	println("=== 1. Variables & Mutability ===")

	// 1. Immutability by Default
	// V variables are immutable by default. Once assigned, their values cannot change.
	x := 42 // Type is inferred as 'int'
	println("x is: ${x}")

	// Un-commenting the line below will cause a compile-time error:
	// x = 100 // error: `x` is immutable, declare it with `mut` to make it mutable

	// 2. Mutable Variables
	// To allow re-assignment, you must use the `mut` keyword.
	mut y := 10
	println("Initial y: ${y}")
	y = 20
	println("Updated y: ${y}")

	// 3. Explicit Type Declaration
	// V has type inference, but you can explicitly specify the type if needed:
	z := f64(3.14) // casting / declaring double-precision float
	name := "Vlang" // string
	println("z: ${z}, name: ${name}")

	// 4. Value vs Reference Mutability
	// Primitive values are copied. If you want a function to modify a complex structure
	// (like a struct or an array), you must pass it with `mut`.
	// We'll see more of this in the Structs and Arrays demos!
}
