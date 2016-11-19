accessing - position
preLayoutPositionToPostLayout: aPosition
	"Infinite element provides artificial position range (item count) in pre-layout state and 
	automatically maps these positions to DataSource positions when #elementFor: is sent.

	Usually, Layout does not need to worry about this. However, in some cases, your
	Layout may need to call some custom component with item positions in which
	case you need the actual data source position instead of the pre layout position. You
	can use me to convert a pre-layout position to data source (post layout) position.

	Note that if the provided position belongs to a deleted ElementHolder, this method will return 0.
	Using me in post-layout state returns the same value back.

	aPosition must be greater or equal to 1 and less than BlInfiniteElementState>>#itemCount"
	
	(aPosition < 1 or: [ aPosition > self controller stateItemCount ])
		ifTrue: [
			SubscriptOutOfBounds
				signalFor: aPosition
				lowerBound: 1
				upperBound: self controller stateItemCount ].
	
	^ self controller isPreLayout
		ifTrue: [ self controller computePositionOffset: aPosition ]
		ifFalse: [ aPosition ]