# Connect to VGDB
alias valgrind = target remote | vgdb


# Leak summary (Valgrind)
alias leak = monitor leak_check summary reachable any

define step_leak
	s
	leak
end

define next_leak
	n
	leak
end

alias sl = step_leak
alias nl = next_leak


# Full leak (Valgrind)
alias leak_full = monitor leak_check full reachable any

define step_leak_full
	s
	leak_full
end

define next_leak_full
	n
	leak_full
end

alias slf = step_leak_full
alias nlf = next_leak_full
