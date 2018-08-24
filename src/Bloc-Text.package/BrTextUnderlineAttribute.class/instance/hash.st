comparing
hash
	"Compute and return a hash code.
	Two objects for which equals: returns true must have the same hash"
	<return: #Number>

	^ (((self paint hash 
			bitXor: self style hash) 
			bitXor: self width hash)
			bitXor: self opacity hash)
			bitXor: self isBelow hash