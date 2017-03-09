private
moveForward: aNumber

	position := ((position max: 1) + aNumber) min: end + 1.

	self
		assert: [ position <= (end + 1) ]
		description: [ 'Position must not exceed bounds' ].

	currentIterator hasNext
		ifTrue: [ ^ self ].
	
	self hasNext ifFalse: [
		currentIterator := self backwardIteratorAt: position - 1.
		^ self ].
	
	currentIterator := self forwardIteratorAt: position