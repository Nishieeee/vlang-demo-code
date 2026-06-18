# Vlang Coding Assignments & Lab Challenges 🎮

Here are three fun, interactive programming challenges you can assign to your classmates to test their V programming skills. Each challenge focuses on specific language features taught in the demos.

---

## 💡 Challenge 1: The Chat Emoji Decoder (Beginner)
* **Goal:** Create a simple CLI program that scans a chat message and replaces text-based emoticons (like `:)` or `xD`) with native Unicode emojis (like `😊` or `😆`).

### Key Concepts Tested:
* String traversal / Runes
* `match` expressions
* String interpolation and concatenation

### Starter Template (`emoji_decoder.v`):
```v
fn decode_emoticon(code string) string {
	// TODO: Use a match expression to convert text codes to emojis:
	// ':)''   -> '😊'
	// ':D'    -> '😃'
	// ';)'    -> '😉'
	// 'xD'    -> '😆'
	// else    -> the original code
	return match code {
		':)' { '😊' }
		':D' { '😃' }
		';)' { '😉' }
		'xD' { '😆' }
		else { code }
	}
}

fn main() {
	println('=== Emoji Decoder ===')
	
	// Test sentences
	message := 'Hello :) I am learning Vlang today :D it is fun xD'
	words := message.split(' ')
	mut decoded_words := []string{}

	for word in words {
		// Convert word if it's an emoticon
		decoded_words << decode_emoticon(word)
	}

	// Join them back into a sentence
	result := decoded_words.join(' ')
	println('Original: ${message}')
	println('Decoded:  ${result}')
}
```

---

## ⚔️ Challenge 2: Gladiator Arena Simulator (Intermediate)
* **Goal:** Build a turn-based combat simulator. Two fighters (represented by structs) duel automatically in a loop until one of them is knocked out (HP reaches 0).

### Key Concepts Tested:
* Structs with default values
* Mutable receiver methods (`fn (mut f Fighter) ...`)
* Control flow (`for` and `if/else`)
* Standard library random numbers (`import rand`)

### Starter Template (`gladiator_arena.v`):
```v
import rand

struct Gladiator {
	name string
	max_hp int = 100
mut:
	hp int
	min_damage int = 10
	max_damage int = 25
}

// TODO: Create a method that inflicts damage on the opponent
fn (mut g Gladiator) attack(mut target Gladiator) {
	damage := rand.int_in_range(g.min_damage, g.max_damage) or { g.min_damage }
	target.hp -= damage
	if target.hp < 0 {
		target.hp = 0
	}
	println('⚔️ ${g.name} attacks ${target.name} for ${damage} damage! (${target.name} HP: ${target.hp}/${target.max_hp})')
}

fn main() {
	println('=== Welcome to the Gladiator Arena ===\n')

	mut player1 := Gladiator{name: 'Maximus', hp: 100}
	mut player2 := Gladiator{name: 'Commodus', hp: 100}

	mut round := 1
	for player1.hp > 0 && player2.hp > 0 {
		println('--- Round ${round} ---')
		
		// Player 1 attacks Player 2
		player1.attack(mut player2)
		if player2.hp <= 0 {
			break
		}

		// Player 2 attacks Player 1
		player2.attack(mut player1)
		
		println('')
		round++
	}

	println('\n=== Match Over ===')
	if player1.hp > 0 {
		println('🏆 ${player1.name} is victorious!')
	} else {
		println('🏆 ${player2.name} is victorious!')
	}
}
```

---

## 🧩 Challenge 3: Wordle-Lite Guesser (Intermediate+)
* **Goal:** Create a 5-letter word guessing game. The player gets 5 attempts. If a character is in the correct position, highlight it. If it is in the word but wrong position, mark it with `?`. Otherwise, mark it with `x`.

### Key Concepts Tested:
* String indexing / Byte-to-string conversion (`.ascii_str()`)
* String membership check (`.contains()`)
* Arrays & loop range boundaries
* Terminal inputs with `import os`

### Step-by-Step Implementation Guide:

#### Step 1: Import Console Module
Import the `os` module to read terminal input.
```v
import os
```

#### Step 2: Main Entry Point & Initialization
Declare `fn main()`. Initialize the target word and a mutable attempts counter.
```v
fn main() {
	secret_word := 'Vlang' // 5-letter secret word
	mut attempts := 5
	// ...
}
```

#### Step 3: Game Loop
Construct a loop that runs while `attempts > 0`. Compute the current round using `6 - attempts`.
```v
for attempts > 0 {
	// Loop body goes here
}
```

#### Step 4: Capture & Validate Guess
Get the user's input. Check if the guess length is exactly 5. If not, print a warning and use `continue` to start the next iteration without losing an attempt.
```v
guess := os.input('Attempt ${6 - attempts}/5 > ')
if guess.len != 5 {
	println('[Warning] Please enter exactly 5 characters!')
	continue
}
```

#### Step 5: Check for Victory
Compare the lowercase versions of the guess and the secret word. If they match, print the success message and exit using `return`.
```v
if guess.to_lower() == secret_word.to_lower() {
	println('[Success] Correct! You guessed the word: ${secret_word}!')
	return
}
```

#### Step 6: Initialize Feedback List & Character Loop
Create a mutable string array to hold feedback markers and run a loop from `0` to `4` (`0 .. 5`).
```v
mut feedback := []string{}
for i in 0 .. 5 {
	// Process character at index i
}
```

#### Step 7: Byte-to-String Conversions
Since indexing a string returns a byte (`u8`), convert both guess and secret word characters to strings using `.ascii_str()` before comparing.
```v
guess_char := guess[i].ascii_str()
secret_char := secret_word[i].ascii_str()
```

#### Step 8: Apply Wordle Logic
Compare characters and append feedback markers:
* Correct spot: `[C]` (uppercase)
* Wrong spot: `c?` (lowercase with question mark) using `.contains()`
* Not in word: `x` (lowercase)
```v
if guess_char.to_lower() == secret_char.to_lower() {
	feedback << '[${guess_char.to_upper()}]' // Correct position
} else if secret_word.to_lower().contains(guess_char.to_lower()) {
	feedback << '${guess_char.to_lower()}?' // In the word, wrong position
} else {
	feedback << 'x' // Not in the word
}
```

#### Step 9: Render Output & Decrement
Outside the character loop, join the feedback array, print it, and decrement `attempts`. Outside the main game loop, print a Game Over message.
```v
println('Feedback: ${feedback.join(" ")}\n')
attempts--
```

---

### Starter Template (`word_guesser.v`):
```v
import os

fn main() {
	secret_word := 'Vlang' // 5-letter secret word
	mut attempts := 5

	println('=== Wordle-Lite Guesser ===')
	println('Guess the 5-letter word! You have ${attempts} attempts.')

	for attempts > 0 {
		guess := os.input('Attempt ${6 - attempts}/5 > ')
		
		if guess.len != 5 {
			println('[Warning] Please enter exactly 5 characters!')
			continue
		}

		if guess.to_lower() == secret_word.to_lower() {
			println('[Success] Correct! You guessed the word: ${secret_word}!')
			return
		}

		// TODO: 1. Initialize empty mutable feedback array
		// TODO: 2. Loop through each character position (0 to 4)
		// TODO: 3. Convert bytes to ASCII strings using .ascii_str()
		// TODO: 4. Check position match, character existence, or failure
		// TODO: 5. Print feedback, decrement attempts

		println('Feedback: [Not yet implemented]\n')
		attempts-- // Remove when implementation is complete
	}

	println('[Game Over] The secret word was: ${secret_word}')
}
```

---

### Full Solution Code:
```v
import os

fn main() {
	secret_word := 'Vlang' // 5-letter secret word
	mut attempts := 5

	println('=== Wordle-Lite Guesser ===')
	println('Guess the 5-letter word! You have ${attempts} attempts.')

	for attempts > 0 {
		guess := os.input('Attempt ${6 - attempts}/5 > ')
		
		if guess.len != 5 {
			println('[Warning] Please enter exactly 5 characters!')
			continue
		}

		if guess.to_lower() == secret_word.to_lower() {
			println('[Success] Correct! You guessed the word: ${secret_word}!')
			return
		}

		// Process incorrect guess
		mut feedback := []string{}
		for i in 0 .. 5 {
			guess_char := guess[i].ascii_str()
			secret_char := secret_word[i].ascii_str()

			if guess_char.to_lower() == secret_char.to_lower() {
				feedback << '[${guess_char.to_upper()}]' // Correct position
			} else if secret_word.to_lower().contains(guess_char.to_lower()) {
				feedback << '${guess_char.to_lower()}?' // In the word, wrong position
			} else {
				feedback << 'x' // Not in the word
			}
		}

		println('Feedback: ${feedback.join(" ")}\n')
		attempts--
	}

	println('[Game Over] The secret word was: ${secret_word}')
}
```
