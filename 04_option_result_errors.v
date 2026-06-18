// 04_option_result_errors.v
// This demo file explains Option (?) and Result (!) types in V, and their error handling.

// 1. A function returning an Option (?int)
// It can return either an integer or `none` (meaning no value, not an error).
fn find_index(target string, list []string) ?int {
	for i, item in list {
		if item == target {
			return i
		}
	}
	return none // returned when target is not found
}

// 2. A function returning a Result (!f64)
// It can return either a float64 or an error with a message.
fn divide(a f64, b f64) !f64 {
	if b == 0.0 {
		return error("cannot divide by zero")
	}
	return a / b
}

// 3. Propagating errors
// If we call a function returning a Result, we can pass it up the stack.
fn calculate_ratio(a f64, b f64) !f64 {
	// Inside an `or` block, we can propagate the error using `return err`
	result := divide(a, b) or {
		return err
	}
	return result
}

fn main() {
	println("=== 4. Option, Result & Error Handling ===")

	fruits := ["apple", "banana", "cherry"]

	// --- OPTION HANDLING (?T) ---
	// Option functions MUST be handled with an `or` block.
	// You can return, panic, or provide a default fallback value.
	
	// Example A: Default fallback value
	index1 := find_index("banana", fruits) or { -1 }
	println("Index of banana: ${index1}") // Outputs 1

	// Example B: Error block execution
	index2 := find_index("durian", fruits) or {
		println("Warning: 'durian' not found! Using fallback index 0.")
		0 // fallback value
	}
	println("Index used: ${index2}")

	// --- RESULT HANDLING (!T) ---
	// Result functions also use the `or` block, but you gain access to a special `err` variable.
	
	// Example C: Successful division
	val1 := divide(10.0, 2.0) or {
		println("Error occurred: ${err}")
		return
	}
	println("10.0 / 2.0 = ${val1}")

	// Example D: Division that triggers the error
	val2 := divide(10.0, 0.0) or {
		println("Error occurred: ${err}") // Prints "cannot divide by zero"
		0.0 // Default value
	}
	println("Result after error recovery: ${val2}")

	// --- IF UNWRAPPING ---
	// An alternative to `or` blocks is "if unwrapping", which lets you run a block only if it succeeds.
	if idx := find_index("cherry", fruits) {
		println("Found cherry at index ${idx}")
	} else {
		println("Cherry was not found")
	}
}
