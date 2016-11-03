private utilities
fill: anArray from: fromIndex to: toIndex with: value
	"To index exclusive"
	
	"Make sure that fromIndex is within bounds"
	((fromIndex <= toIndex) and: [
			(fromIndex > 0 and: [ anArray isNotEmpty ]) or: [
				fromIndex = 0 and: [
					anArray isEmpty ] ] ] )
		ifFalse: [
			SubscriptOutOfBounds
				signalFor: fromIndex
				lowerBound: (anArray ifEmpty: [ 0 ] ifNotEmpty:  [ 1 ])
				upperBound: anArray size + 1
				in: anArray ].
			
	"Make sure that toIndex is within bounds"
	((toIndex <= (anArray size + 1)) and: [
			(toIndex > 1) or: [
				toIndex = 1 and: [
					anArray isEmpty ] ] ] )
		ifFalse: [
			SubscriptOutOfBounds
				signalFor: toIndex
				lowerBound: (anArray ifEmpty: [ 0 ] ifNotEmpty:  [ 1 ])
				upperBound: anArray size + 1
				in: anArray ].
	
	"Do nothing if empty"
	anArray
		ifEmpty: [
			self
				assert: [ (fromIndex + 1) = toIndex and: [ fromIndex = 0 ] ]
				description: [ 'From must be equal 0 and to equal 1 if array is empty' ].
			^ self ].
	
	anArray
		atAll: (fromIndex to: toIndex - 1)
		put: value