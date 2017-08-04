invariant
invariant
	"Return true if class invariant holds, false otherwise.
	An invariant is that ===from=== must be always smaller or equal to ===to=== and both must not be negative"
	<return: #Boolean>

	^ from <= to
		and: [ from >= 0
			and: [ to >= 0 ] ]