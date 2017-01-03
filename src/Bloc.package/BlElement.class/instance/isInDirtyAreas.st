testing
isInDirtyAreas
	"Return true if I am within dirty areas, even partially, false otherwise"
	<return: #Boolean>

	^ self isAttachedToSceneGraph and: [
			| aBoundsInSpace |
			aBoundsInSpace := self boundsInSpace.
			self space dirtyAreas anySatisfy: [ :aRectangle |
				aBoundsInSpace intersects: aRectangle ] ]