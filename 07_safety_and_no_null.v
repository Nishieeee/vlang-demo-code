// 07_safety_and_no_null.v
// This demo file explains V's safety features: the absence of null/nil, optional fields, and required attributes.

struct Profile {
	// 1. Optional fields in V structs are declared using the `?Type` syntax.
	// This replaces nullable fields. If not set, it defaults to `none`.
	bio ?string
}

struct User {
	name string
	// 2. Struct fields must be initialized when creating a struct.
	// You can mark a field as required using the `@[required]` attribute.
	// The compiler will reject instantiation if this field is missing.
	email string @[required]
	
	// Optional struct field
	profile ?Profile
}

fn main() {
	println("=== 7. Safety, No Null, and Required Fields ===")

	// 1. No Null / Nil pointer errors
	// In languages like Java, C++, Go, or Python, a variable can be null and crash your program at runtime.
	// In V, this is impossible. Variables must have a value, or they must be marked as optional.

	// 2. Initializing a struct with required fields
	// If you try to create a User without `email`, it will fail to compile.
	u1 := User{
		name: "Jane Doe"
		email: "jane@example.com"
		// 'profile' is not provided, so it defaults to `none`
	}
	println("User created: ${u1.name} <${u1.email}>")

	// 3. Handling optional fields safely
	// We check if the optional field exists using `if` unwrapping:
	if profile := u1.profile {
		println("User profile is set.")
		if bio := profile.bio {
			println("Bio: ${bio}")
		} else {
			println("Profile exists but has no bio.")
		}
	} else {
		// This block executes because 'profile' is `none`
		println("User profile is not set (it is none).")
	}

	// 4. Creating a user with a profile and bio
	u2 := User{
		name: "John Smith"
		email: "john@example.com"
		profile: Profile{
			bio: "Vlang programmer!"
		}
	}

	// Unwrapping u2's profile and bio
	if profile := u2.profile {
		if bio := profile.bio {
			println("\n${u2.name}'s Bio: ${bio}")
		}
	}
}
