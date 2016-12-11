operations
and: aFlagsOrNumber
	"Return new instance of infinite flags which is a result of bitwise and
	with provided flags or a number"
	<return: #BlInfiniteFlags>

	^ self class fromValue: (self value & (aFlagsOrNumber value))