// 03_structs_and_methods.v
// This demo file explains V's structs, field access modifiers, and methods.

// 1. Defining a Struct
// In V, structs are very clean. Fields are private and immutable by default.
struct GameCharacter {
	name string    // private & immutable (default)
	max_hp int = 100 // default value field, private & immutable
mut:
	hp int         // private & mutable
pub:
	level int = 1  // public & immutable (read-only outside this file/module)
pub mut:
	experience int // public & mutable
}

// 2. Defining Methods
// Methods are functions with a "receiver" specified before the function name.
// By default, the receiver is immutable.
fn (c GameCharacter) display_status() {
	println("--- Character Status ---")
	println("Name: ${c.name} (Lvl ${c.level})")
	println("HP:   ${c.hp}/${c.max_hp}")
	println("XP:   ${c.experience}")
}

// 3. Defining Mutable Methods
// If a method needs to modify a struct field, the receiver must be marked `mut`.
fn (mut c GameCharacter) take_damage(amount int) {
	c.hp -= amount
	if c.hp < 0 {
		c.hp = 0
	}
	println("${c.name} took ${amount} damage!")
}

fn (mut c GameCharacter) gain_xp(amount int) {
	c.experience += amount
	if c.experience >= 100 {
		c.level += 1
		c.experience -= 100
		c.max_hp += 20
		c.hp = c.max_hp
		println("🎉 Level UP! ${c.name} is now level ${c.level}!")
	}
}

fn main() {
	println("=== 3. Structs & Methods ===")

	// 4. Initializing a Struct
	// Struct instantiation must specify the field names.
	mut hero := GameCharacter{
		name: "Aragorn"
		hp: 100
		experience: 0
	}

	// Display initial status
	hero.display_status()

	// 5. Calling Mutating Methods
	// Note that the instance `hero` must be declared as `mut` to allow calling mutable methods!
	hero.take_damage(30)
	hero.display_status()

	// Direct field mutation (only allowed for fields in the `mut` or `pub mut` sections)
	hero.experience = 90
	println("\nGaining XP...")
	hero.gain_xp(20) // should trigger level up

	hero.display_status()
}
