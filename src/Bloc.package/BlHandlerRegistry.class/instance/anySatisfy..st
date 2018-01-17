api - enumerating
anySatisfy: aBlock
	"Evaluate aBlock with every registered event handler.
	If aBlock returns true for any element return true.
	Otherwise return false."
	<return: #Boolean>

	self do: [ :aHandler | (aBlock value: aHandler) ifTrue: [ ^ true ] ].
	^ false