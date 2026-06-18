# Introduction to V (Vlang) 🚀

This repository contains a set of basic, self-contained coding examples designed to introduce V's syntax, design principles, and unique features to your classmates.

## What is V?

V is a statically-typed compiled systems programming language designed for building maintainable software. It is heavily inspired by Go, Rust, Swift, and Kotlin, combining the simplicity of Go with the safety features of Rust.

### Key Highlights / "The Niche"

1. **Extreme Compilation Speed:** V compiles ~1.2 million lines of code per second per CPU core. It compiles directly to C (and then to native machine code) or directly to native machine code (x64/ARM64).
2. **Simplicity:** The language can be learned in an hour. It has no global state (by default), no undefined behavior, and only one way of doing things.
3. **No Null/Nil:** V eliminates the "billion-dollar mistake" at compile time.
4. **Immutability by Default:** All variables and struct fields are immutable unless explicitly marked with `mut`.
5. **No Garbage Collector (by default):** V uses a tracing GC (Boehm GC) by default, but supports experimental compile-time memory management (`-autofree`) or manual management (`-gc none`).
6. **Zero Dependencies:** The compiler is a single binary (~10MB) with no dependencies, and compiles itself in under a second.

---

## Getting Started

### 1. Installation

* **Windows:**
  Using Chocolatey:
  ```powershell
  choco install v
  ```
  Or manual installation:
  ```powershell
  git clone https://github.com/vlang/v
  cd v
  make.bat
  ```

* **macOS / Linux:**
  Using Homebrew:
  ```bash
  brew install vlang
  ```
  Or manual installation:
  ```bash
  git clone https://github.com/vlang/v
  cd v
  make
  # (Optional) Add v to your PATH
  sudo ./v symlink
  ```

### 2. How to Run the Demo Files

You can run any V file directly using the `v run` command:

```bash
v run 00_basics_control_flow.v
v run 01_variables_mutability.v
v run 02_runes_and_strings.v
v run 03_structs_and_methods.v
v run 04_option_result_errors.v
v run 05_arrays_and_maps.v
v run 06_concurrency.v
v run 07_safety_and_no_null.v
```

---

## Presentation Walkthrough & Demo Files Directory

| File | Topic | What to Show |
| :--- | :--- | :--- |
| **`00_basics_control_flow.v`** | Basic Syntax & Control Flow | Demonstrate standard printing, `if`/`else` statements and expressions, match expressions, and standard loops. |
| **`01_variables_mutability.v`** | Variables & Mutability | Show how variables are immutable by default and how `mut` makes them mutable. |
| **`02_runes_and_strings.v`** | Runes & Strings | Show that string length counts bytes, not characters (due to UTF-8). Introduce runes (single Unicode code points) using backticks (`` `🚀` ``) and safe string traversal. |
| **`03_structs_and_methods.v`** | Structs & Methods | Explain field accessibility (`pub`, `mut`, `pub mut`) and receiver mutability (`fn (mut c GameCharacter) ...`). |
| **`04_option_result_errors.v`** | Options, Results & Errors | Explain `?T` (Option) and `!T` (Result), returning `none`/`error()`, and the compulsory `or { ... }` block. |
| **`05_arrays_and_maps.v`** | Arrays & Maps | Show array appending (`<<`), functional-style methods (`.filter()`, `.map()`) using `it`, and safe map lookup. |
| **`06_concurrency.v`** | Concurrency | Show how easy concurrency is using `spawn`, thread handles with `.wait()`, and shared memory protection using `lock`. |
| **`07_safety_and_no_null.v`** | Safety & No Null | Show V's design for preventing null-pointer exceptions, struct field validation (`@[required]`), and unwrapping. |

---

Have fun presenting V to your classmates! 💻
