// 00_basics_control_flow.v
// This demo file covers V's basic syntax: printing, conditions, match, and loops up to arrays.
import os
fn main() {
	println("=== 0. Basic Syntax, Conditions, and Loops ===")

	// 1. Comments & Printing
	// Double slashes are for single-line comments.
	/* Multi-line comments
	   look like this. */
	print("Hello ")    // print() doesn't add a newline
	println("World!")  // println() adds a newline
	name := os.input('Enter your name: ')
	println("Hello, ${name}")
	// 2. Conditions: if / else
	// Parentheses are NOT required around the condition, but curly braces {} are mandatory.
	score := 85
	if score >= 90 {
		println("Grade: A")
	} else if score >= 80 {
		println("Grade: B")
	} else {
		println("Grade: F")
	}

	// 3. IF as an Expression
	// In V, 'if' is an expression, meaning it can return a value (similar to the ternary operator `? :` in C/Java).
	a := 10
	b := 20
	max := if a > b { a } else { b }
	println("The maximum value is: ${max}")

	// 4. Match (V's switch statement)
	// 'match' is cleaner and safer than 'switch' statements in other languages.
	// You don't need 'break' statements; only the matching block runs.
	finger := 3
	match finger {
		1 { println("Thumb") }
		2 { println("Index") }
		3 { println("Middle") }
		4 { println("Ring") }
		5 { println("Pinky") }
		else { println("Invalid finger number") } // 'else' is mandatory if all possible values aren't covered
	}

	// MATCH can also be used as an expression!
	finger_name := match finger {
		1 { "Thumb" }
		2 { "Index" }
		3 { "Middle" }
		4 { "Ring" }
		5 { "Pinky" }
		else { "Unknown" }
	}
	println("Finger name: ${finger_name}")

	// 5. Loops: for
	// In V, 'for' is the ONLY looping keyword. It does everything.
	
	// A. While-style loop (condition loop)
	println("\nWhile-style loop:")
	mut count := 1
	for count <= 3 {
		println("  Count: ${count}")
		count++
	}

	// B. Range-style loop (0 to 4)
	println("\nRange-style loop (0 .. 5):")
	for i in 0 .. 5 {
		println("  Index: ${i}") // prints 0, 1, 2, 3, 4 (5 is exclusive)
	}

	// C. C-style for loop
	println("\nC-style for loop:")
	for i := 0; i < 3; i++ {
		println("  C-Style index: ${i}")
	}

	// D. Iterating over an Array
	println("\nIterating over an Array:")
	fruits := ["Apple", "Banana", "Cherry"]
	
	// Iterating values only:
	for fruit in fruits {
		println("  Fruit: ${fruit}")
	}

	// Iterating index and value together:
	for idx, fruit in fruits {
		println("  Fruit at index ${idx}: ${fruit}")
	}
}
