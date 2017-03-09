text - lock
lockDuring: aBlock
	"Prevent any text modifications while evaluating a given block"
	| wasLocked |

	wasLocked := self isLocked.
	self lock.
	aBlock ensure: [ wasLocked ifFalse: [ self unlock ] ]