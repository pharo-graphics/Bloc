invariant
invariant
	"Return true if class invariant holds, false otherwise.
	An invariant is that ===from=== must be always smaller or equal to ===to=== and both must not be negative"
	<return: #Boolean>

	^ _from <= _to
		and: [ _from >= 0
			and: [ _to >= 0 ] ]