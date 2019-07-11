# Linux CPU scheduling
Learning to share your toys

---

# What is this talk about?
How computers work

Not _everything_ about how computers work

---

# What is this talk about?
Specifically CPU scheduling when you have multiple processes on a Linux computer

---

# What is this talk NOT about?
FreeBSD, Darwin, Windows, your TI-84+, Arduino, etc

---

# Linux Only

---

# What parts of linux?
The Completely Fair Scheduler (CFS)

Default process scheduler since 2.6.23 (October 2007)

Con Kolivas - also the person who wrote CGMiner

Replaced the O(1) scheduler

---

# Why do you need a scheduler?

---

If you have a CPU with one core and two processes

---

Most processes don't do much work

---

Most processes do a lot of waiting

CPU Cache I/O, Disk I/O, Network I/O, etc

---

How do you utilize your computer when that process is waiting on I/O?

---

# Process scheduling!
Allows multiple processes to use the same CPU core.

---

When a process is waiting it is de-scheduled and the CPU core is given to another process that has work to do.

---

# How does the CFS do this?

---

"Via a red-black tree timeline of future tasks which uses nanosecond granularity accounting for allocating an individual process' share of the CPU." - Wikipedia

---

![](/images/sponge_bob.png)

---

We're not going to talk about red-black trees

---

This talk is going to give you a mental model of how this scheduler works and how it applies to linux containers.

