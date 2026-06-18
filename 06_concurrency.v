// 06_concurrency.v
// This demo file explains concurrency in V: spawning threads, waiting for results, and using shared data locks.

import time

// A simple function that does some work and returns a value
fn calculate_square(id int, n int) int {
	println("  [Thread ${id}] Starting work on ${n}...")
	time.sleep(500 * time.millisecond) // Simulate some work
	result := n * n
	println("  [Thread ${id}] Work finished. Result: ${result}")
	return result
}

// Struct to hold shared state
struct Counter {
mut:
	value int
}

// Function to safely increment a shared struct
fn increment_counter(shared c Counter) {
	for _ in 0 .. 5 {
		// To access or modify a shared variable, you must wrap it in a `lock` block.
		// This acts like a Mutex lock, ensuring thread-safe access.
		lock c {
			c.value++
		}
		time.sleep(50 * time.millisecond)
	}
}

fn main() {
	println("=== 6. Concurrency ===")

	// --- 1. Spawning a single thread & waiting ---
	println("\n1. Spawning a single thread:")
	
	// 'spawn' runs the function concurrently on an OS thread.
	// It returns a thread handle.
	handle := spawn calculate_square(1, 8)
	
	println("Main thread is doing other work...")
	time.sleep(200 * time.millisecond)
	
	// Wait for the thread to complete and retrieve its return value.
	ans := handle.wait()
	println("Main thread got answer: ${ans}")

	// --- 2. Spawning multiple threads (Array of Threads) ---
	println("\n2. Spawning multiple threads:")
	
	mut threads := []thread int{}
	
	// Start 3 concurrent workers
	threads << spawn calculate_square(2, 5)
	threads << spawn calculate_square(3, 10)
	threads << spawn calculate_square(4, 12)
	
	println("Spawning complete. Waiting for all threads to finish...")
	
	// We can wait for all threads in the array at once!
	// This returns an array of the results.
	results := threads.wait()
	println("All threads finished. Results received: ${results}") // Outputs: [25, 100, 144]

	// --- 3. Shared Data & Synchronization ---
	println("\n3. Shared Data & Locks:")
	
	// Initialize a shared struct
	shared my_counter := Counter{value: 0}
	
	// Spawn two threads that will mutate the same variable
	t1 := spawn increment_counter(shared my_counter)
	t2 := spawn increment_counter(shared my_counter)
	
	// Wait for both increment tasks to finish
	t1.wait()
	t2.wait()
	
	// Access the shared variable in the main thread (requires rlock or lock)
	rlock my_counter {
		println("Final Counter Value (thread safe): ${my_counter.value}") // Output: 10
	}
}
