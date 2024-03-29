# Linux CPU scheduling

## Learning to share your toys

Gabe Ochoa

Slack: @gochoa | Twitter: @gabe_ochoa

Email: gochoa@squarespace.com

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

# What parts of Linux?

### The Completely Fair Scheduler (CFS)

- Default process scheduler since 2.6.23 (October 2007)
- implementation weighted fair queueing algorithm (networking packets)

- Con Kolivas - also the person who wrote CGMiner

- Replaced the O(1) scheduler

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
Allows multiple processes to use the same CPU core

---

When a process is waiting it is paused and the CPU core is given to another process that has work to do

---

# How does the CFS do this?

---

"Via a red-black tree timeline of future tasks which uses nanosecond granularity accounting for allocating an individual process' share of the CPU." - Wikipedia

---

![](/images/sponge_bob.png)

---

We're not going to talk about red-black trees

---

This talk is going to give you a mental model of how this scheduler works and how it applies to Linux containers and applications

---

Each second is broken up into discrete time slices

---

Each of these time slices can be given to a process to use

![](/images/a5FvW.png)

---

It is the job of the CFS to allocate these slices to processes
---

This is done via CPU Shares

---

# CPU Shares

---

CPU shares divide each core into 1024 slices and *guarantees* that each process will receive its *proportional* share of those slices

---

However, if one process doesn’t use its shares the other is free to

---

If there are 1024 slices and each of two processes sets `cpu.shares` to 512,
then they will each get about half of the available time every second

---

Let's look at an example if we have 5 processes

| Process ID | `cpu.shares` | Portion of time slices |
|---|---|---|
|1|100|9.7%|
|2|200|19.5%|
|3|175|17%|
|4|500|48.8%|
|5|49|4.7%|
|Totals|1024|100%|

---

Again, a process is _guaranteed_ its shares every second

Unused shares can be given to another process

---

All good?

---

We have a problem though

---

The CPU shares system in the CFS cannot enforce upper bounds. If one process doesn’t use its share the other is free to.

---

Around 2010, Google noticed that giving unused shares to another process could cause issues

They went and built the "CPU bandwidth control system" into the CFS

https://ai.google/research/pubs/pub36669

---

"There are many scenarios where this unbounded CPU share may lead to unacceptable utilization or latency variation. CPU bandwidth control approaches this problem by allowing an explicit upper bound for allowable CPU bandwidth to be defined in addition to the lower bound already provided by shares. "

---

TL:DR We need a CPU limit because sometimes the unbounded process affects other things on the system

---

The bandwidth control system defines a period over which it does enforcement

The default for _most_ Linux distros is 100ms, ours in Kubernetes is set to 10ms

`cpu.cfs_period_us`

---

That is to say every 10ms the bandwidth control system checks in and makes sure each process is still behaving well

---

Each process can then define a quota for the bandwidth control system to enforce

`cpu.cfs_quota_us`

A quota represents the maximum number of slices in that enforcement period (10ms) that a process is allowed to run on the CPU

---

This enforcement is separate from the time slice allocation via CPU shares

The system enforces the quota at process scheduling so the process will not been allowed to execute if it is over quota

A process can’t exceed the set CPU quota, and will never get evicted or killed for trying to use more CPU time than allocated

---

Let's look at some examples again

---

5 processes, now with quotas

| Process ID | `cpu.shares` | Portion of time slices | `cpu.quota`
|---|---|---|---|
|1|100|9.7%|500|
|2|100|9.7%|500|
|3|100|9.7%|500|
|4|500|48.8%|1024|
|5|850|4.7%|225|
|Unused|174|17.4|-|
|Totals|850|82.6%|2749|

---

CPU shares are guaranteed.

Any extra slices must come from other processes or free slices.

Any slices over the CPU shares are given only if they are available.

---

How does this affect us?

---

# Kubernetes

requests = cpu.shares

limits = cpu.quota

These are base 10 (1000 slices per core)

Docker converts them to base 2 (1024 slices per core)

---

People ask the question:

"How many cores is my application using?"

---

This is the wrong question (even for VMs)

---

"How much CPU has my application used over 1 hour?"

---
A Note:

On multi-core machines the shares are calculated over all the CPU cores on the machines

It's important to tell your application how many shares it has

ConcGCThreads,ParallelGCThreads,GOMAXPROCS, etc

---

In summary:

CPU shares (Kubernetes requests) are guaranteed

CPU quota (Kubernetes limits) are best effort if there are free cycles

---

# Thank you


Gabe Ochoa

Slack: @gochoa | Twitter: @gabe_ochoa

Email: gochoa@squarespace.com
