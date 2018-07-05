private
backwardIteratorAt: aPosition
	| aCurrentRope aCurrentPosition |

	aCurrentRope := rope.
	aCurrentPosition := aPosition.
	
	[ aCurrentRope isConcatenation ] whileTrue: [ 
		aCurrentRope := (aCurrentPosition <= aCurrentRope left size)
			ifTrue: [ aCurrentRope left ]
			ifFalse: [
				aCurrentPosition := aCurrentPosition - aCurrentRope left size.
				aCurrentRope right ] ].

	^ aCurrentRope
		iterator: aCurrentPosition
		to: ((aCurrentPosition - (aPosition - start + 1)) max: 1)