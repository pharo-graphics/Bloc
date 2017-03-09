private
moveBackward

	position := (position - 1) min: end.
	
	currentIterator hasPrevious
		ifTrue: [ ^ self ].

	self hasPrevious ifFalse: [
		currentIterator := self forwardIteratorAt: position + 1.
		^ self ].
	
	currentIterator := self backwardIteratorAt: position