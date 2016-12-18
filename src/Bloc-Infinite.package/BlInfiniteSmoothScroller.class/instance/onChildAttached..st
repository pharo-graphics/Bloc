hooks
onChildAttached: anElement
	"Sent when an item element is attached to this InfiniteElement.
	If attached element corresponds to my target position it becomes my target element"

	(self childPositionOf: anElement) = self targetPosition
		"smooth scroll target element has been attached"
		ifTrue: [ targetElement := anElement ]