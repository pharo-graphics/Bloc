text - enumeration
allSatisfy: aBlock
	"Evaluate aBlock with all text character's.
	If aBlock returns false for any element return false, otherwise return true"
	<return: #Boolean>

	self do: [ :aCharacter | (aBlock value: aCharacter)
		ifFalse: [ ^ false] ].
	^ true