// 05_arrays_and_maps.v
// This demo file explains V's built-in arrays and maps, highlighting their syntax and helper methods.

fn main() {
	println("=== 5. Arrays & Maps ===")

	// ==========================================
	// PART 1: ARRAYS
	// ==========================================
	println("\n--- Array Operations ---")

	// 1. Defining a mutable array
	// In V, arrays are dynamic. Use `mut` to allow appending or modifying.
	mut nums := [1, 2, 3]
	println("Initial array: ${nums}")

	// 2. Appending elements
	// Use the `<<` operator to append elements.
	nums << 4
	println("After appending 4: ${nums}")

	// You can also append another array
	nums << [5, 6, 7]
	println("After appending [5, 6, 7]: ${nums}")

	// 3. Array Slicing
	// Slicing syntax is `array[start..end]`. The end index is exclusive.
	slice := nums[1..4]
	println("Slice [1..4] (index 1 to 3): ${slice}") // Outputs: [2, 3, 4]

	// 4. Functional Helpers: .filter() and .map()
	// Inside filter and map, the implicit variable `it` represents the current element.
	
	// Filter: Keep only even numbers
	evens := nums.filter(it % 2 == 0)
	println("Filtered (Evens): ${evens}")

	// Map: Double each number
	doubled := nums.map(it * 2)
	println("Mapped (Doubled): ${doubled}")

	// Chaining filter and map:
	result := nums.filter(it > 2).map(it * 10)
	println("Chained (greater than 2, multiplied by 10): ${result}")


	// ==========================================
	// PART 2: MAPS (Dictionaries / Key-Value Pairs)
	// ==========================================
	println("\n--- Map Operations ---")

	// 1. Initializing a Map
	// Key type is typically string, value can be any type.
	mut ages := {
		"Alice": 25
		"Bob":   30
	}
	println("Ages Map: ${ages}")

	// 2. Modifying or Adding values
	ages["Charlie"] = 35
	println("After adding Charlie: ${ages}")

	// 3. Checking for Key Existence
	// Use the `in` or `!in` operators.
	if "Alice" in ages {
		println("Alice is in the map.")
	}

	// 4. Safe Map Access with `or` block
	// Direct access return default values (like 0 for int) if not found.
	// But using `or` allows explicit fallback handling!
	dave_age := ages["Dave"] or {
		println("Dave not found in map! Defaulting to 0.")
		0
	}
	println("Dave's age: ${dave_age}")

	// Or use "if unwrapping" to conditionally process the value
	if age := ages["Bob"] {
		println("Bob's age is ${age}")
	} else {
		println("Bob's age is not recorded.")
	}
}
