testing
isInDirtyAreas
	"Return true if I am within dirty areas, even partially, false otherwise"
	<return: #Boolean>

	^ self dirty
		ifTrue: [ true ]
		ifFalse: [
			self space isNotNil and: [
				| aBoundsInSpace |
				aBoundsInSpace := self boundsInSpace.
				self space dirtyAreas anySatisfy: [ :each |
					aBoundsInSpace intersects: each ] ] ]