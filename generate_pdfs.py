import os
from fpdf import FPDF

# Define the custom PDF class for a professional lab assignment sheet
class VlangLabPDF(FPDF):
    def header(self):
        # Top brand line
        self.set_fill_color(15, 23, 42) # Slate 900 primary color
        self.rect(0, 0, 210, 12, 'F')
        
        self.set_y(3)
        self.set_font('helvetica', 'B', 8)
        self.set_text_color(255, 255, 255)
        self.cell(0, 6, 'VLANG PROGRAMMING LAB - ASSIGNMENT DOCUMENT', align='C')
        self.ln(12)

    def footer(self):
        # Bottom rule and page number
        self.set_y(-15)
        self.set_draw_color(226, 232, 240) # Slate 200
        self.line(15, 280, 195, 280)
        
        self.set_font('helvetica', 'I', 8)
        self.set_text_color(100, 116, 139) # Slate 500
        self.cell(0, 10, f'Page {self.page_no()}/{{nb}}', align='C')

    def check_page_fit(self, height):
        # Check if printing something of 'height' will cause a page break.
        # If so, proactively insert a page break to avoid orphan elements.
        if self.get_y() + height > 268:
            self.add_page()

    def add_title(self, title):
        self.check_page_fit(20)
        self.set_font('helvetica', 'B', 16)
        self.set_text_color(15, 23, 42) # Slate 900
        self.cell(0, 10, title)
        self.ln(12)

    def add_section_header(self, heading):
        self.check_page_fit(15)
        self.set_font('helvetica', 'B', 12)
        self.set_text_color(2, 132, 199) # Sky 600
        self.cell(0, 8, heading)
        self.ln(10)

    def add_body_text(self, text):
        self.check_page_fit(10)
        self.set_font('helvetica', '', 9.5)
        self.set_text_color(51, 65, 85) # Slate 700
        self.multi_cell(0, 5, text)
        self.ln(3)

    def add_bullet_point(self, bold_prefix, text):
        self.check_page_fit(15)
        self.set_font('helvetica', 'B', 9.5)
        self.set_text_color(15, 23, 42)
        self.write(5, '- ' + bold_prefix + ': ')
        self.set_font('helvetica', '', 9.5)
        self.set_text_color(51, 65, 85)
        self.write(5, text + '\n')
        self.ln(2)

    def add_code_block(self, code):
        self.set_font('courier', '', 8.5)
        self.set_text_color(30, 41, 59) # Slate 800
        self.set_fill_color(248, 250, 252) # Slate 50 background
        self.set_draw_color(226, 232, 240) # Slate 200 border
        
        # Calculate height needed (lines * leading + padding)
        lines = code.split('\n')
        h = len(lines) * 4.5 + 6
        
        # Make sure it fits
        self.check_page_fit(h)
        
        # Draw background and text
        self.multi_cell(0, 4.5, code, border=1, fill=True)
        self.ln(3)

    def add_step(self, step_num, title, description, code_snippet=None):
        # Restructures step details as a clean, cohesive group
        self.check_page_fit(30)
        
        # Step Title
        self.set_font('helvetica', 'B', 10.5)
        self.set_text_color(15, 23, 42)
        self.cell(0, 6, f'Step {step_num}: {title}')
        self.ln(6)
        
        # Step Description
        self.set_font('helvetica', '', 9.5)
        self.set_text_color(71, 85, 105) # Slate 600
        self.multi_cell(0, 5, description)
        self.ln(2)
        
        # Inline Code Snippet
        if code_snippet:
            self.add_code_block(code_snippet)
        self.ln(2)

def generate_assignment_pdf(output_filename, include_final_code):
    pdf = VlangLabPDF()
    pdf.alias_nb_pages()
    
    # Set standard margins (15mm left/right, 20mm top/bottom)
    pdf.set_margins(15, 20, 15)
    pdf.add_page()
    
    # Document title
    pdf.add_title('Coding Challenge: Wordle-Lite Guesser')
    
    # Objective
    pdf.add_section_header('Objective:')
    pdf.add_body_text(
        'In this assignment, you will build a text-based, simplified version of the popular game Wordle in V (Vlang). '
        'This challenge is designed to help you practice core V programming concepts up to arrays and strings, '
        'including string indexing, byte-to-string conversion, array operations, and custom control flow with loop and match structures.'
    )
    
    # Game Rules
    pdf.add_section_header('Game Rules & Specification:')
    pdf.add_bullet_point('Secret Word', 'The player must guess a pre-defined 5-letter word (e.g., "Vlang").')
    pdf.add_bullet_point('Attempts Limit', 'The player has exactly 5 attempts to guess the secret word.')
    pdf.add_bullet_point('Validation', 'If a guess is not exactly 5 letters long, print a warning and let the player try again without losing an attempt.')
    pdf.add_bullet_point('Feedback Markers', 'For every incorrect guess, display the following feedback for each position:\n'
                         '   - [C] (Uppercase character in brackets) if the letter is correct and in the correct spot.\n'
                         '   - c? (Lowercase character with a question mark) if the letter is in the word but in the wrong spot.\n'
                         '   - x (Lowercase letter x) if the letter is not in the secret word at all.')
    pdf.add_bullet_point('Victory', 'If the player guesses the word correctly, display a victory message and terminate immediately.')
    pdf.add_bullet_point('Game Over', 'If the player runs out of guesses, display a Game Over message and reveal the secret word.')
    pdf.ln(4)

    # Step-by-Step Instructions
    pdf.add_section_header('Step-by-Step Implementation Guide:')
    
    pdf.add_step(
        1, 'Import Console Module',
        'Import the standard `os` module at the top of your file. V\'s standard library uses `os.input()` to read text input from the terminal.',
        'import os'
    )

    pdf.add_step(
        2, 'Main Entry Point & Game Setup',
        'Declare your `fn main()`. Initialize the target word `secret_word` (immutable string) and a mutable variable `attempts` set to 5.',
        'fn main() {\n\tsecret_word := \'Vlang\'\n\tmut attempts := 5\n}'
    )

    pdf.add_step(
        3, 'Construct the Game Loop',
        'Create a `for attempts > 0` loop. All guess validations and processing logic will execute inside this loop block.',
        'for attempts > 0 {\n\t// Loop body goes here...\n}'
    )

    pdf.add_step(
        4, 'Fetch & Validate Guess Input',
        'Prompt the player to enter a 5-letter word. If the length is not equal to 5, print a warning and use `continue` to start the next iteration immediately without consuming an attempt.',
        'guess := os.input(\'Attempt ${6 - attempts}/5 > \')\nif guess.len != 5 {\n\tprintln(\'[Warning] Please enter exactly 5 characters!\')\n\tcontinue\n}'
    )

    pdf.add_step(
        5, 'Handle Direct Match (Victory Condition)',
        'Convert both the player\'s guess and the secret word to lowercase using `.to_lower()` and check for equality. If they are equal, output the success text and terminate the program using `return`.',
        'if guess.to_lower() == secret_word.to_lower() {\n\tprintln(\'[Success] Correct! You guessed the word: ${secret_word}!\')\n\treturn\n}'
    )

    pdf.add_step(
        6, 'Process Incorrect Guess (Setup Feedback list)',
        'Create a mutable array `feedback` to collect markers. Run a loop from `0` to `4` (using `for i in 0 .. 5`) to check each letter position.',
        'mut feedback := []string{}\nfor i in 0 .. 5 {\n\t// Inspect character at index i...\n}'
    )

    pdf.add_step(
        7, 'Handle Byte-to-String Conversion',
        'V strings are UTF-8 byte arrays under the hood. Indexing `guess[i]` returns a byte (`u8`). You must call `.ascii_str()` to convert them to strings before performing string-matching operations.',
        'guess_char := guess[i].ascii_str()\nsecret_char := secret_word[i].ascii_str()'
    )

    pdf.add_step(
        8, 'Evaluate Letter Match Logic',
        'Check the match rules for each index: if it matches the same index in the secret word, append `[C]` (uppercase in brackets); if it exists elsewhere in the word, append `c?` (using `.contains()`); otherwise, append `x`.',
        'if guess_char.to_lower() == secret_char.to_lower() {\n\tfeedback << \'[${guess_char.to_upper()}]\' // Correct position\n} else if secret_word.to_lower().contains(guess_char.to_lower()) {\n\tfeedback << \'${guess_char.to_lower()}?\' // Wrong position\n} else {\n\tfeedback << \'x\' // Not in word\n}'
    )

    pdf.add_step(
        9, 'Display Output & Decrement Attempts',
        'Outside the character loop (but inside the main game loop), join the markers using `feedback.join(" ")` and print it. Decrement the `attempts` variable.',
        'println(\'Feedback: ${feedback.join(" ")}\\n\')\nattempts--'
    )
    
    pdf.ln(2)

    # Starter Template
    pdf.add_section_header('Starter Code Template:')
    starter_code = """import os

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

		println('Feedback: [Not yet implemented]\\n')
		attempts-- // Remove when implementation is complete
	}

	println('[Game Over] The secret word was: ${secret_word}')
}"""
    pdf.add_code_block(starter_code)
    
    if include_final_code:
        # Full code section
        pdf.add_page()
        pdf.add_title('Appendix: Full Solution')
        pdf.add_body_text('Refer to the source code below for a full, functioning implementation of the Wordle-Lite game in V:')
        
        full_code = """import os

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

		println('Feedback: ${feedback.join(" ")}\\n')
		attempts--
	}

	println('[Game Over] The secret word was: ${secret_word}')
}"""
        pdf.add_code_block(full_code)

    # Save file
    pdf.output(output_filename)
    print(f"Generated PDF: {output_filename}")

if __name__ == '__main__':
    generate_assignment_pdf('vlang_wordle_lite_no_code.pdf', False)
    generate_assignment_pdf('vlang_wordle_lite_with_code.pdf', True)
