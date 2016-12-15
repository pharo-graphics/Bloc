hooks
onChildAddedToSceneGraph: anElement

	(self childPositionOf: anElement) = self targetPosition
		"smooth scroll target element has been attached"
		ifTrue: [ targetElement := anElement ]