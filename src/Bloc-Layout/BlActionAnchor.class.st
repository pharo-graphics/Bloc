Class {
	#name : #BlActionAnchor,
	#superclass : #BlAnchor,
	#instVars : [
		'baseAnchor',
		'action'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #accessing }
BlActionAnchor >> action: aValuable [

	action := aValuable
]

{ #category : #applying }
BlActionAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ baseAnchor
		  appliedOnRectangle: aRectangle
		  withValue: (action cull: aValue cull: self element)
]

{ #category : #accessing }
BlActionAnchor >> baseAnchor: anAnchor [

	baseAnchor := anAnchor
]

{ #category : #accessing }
BlActionAnchor >> element [

	^ baseAnchor element
]

{ #category : #applying }
BlActionAnchor >> valueInBounds: aBounds [

	^ action cull: (baseAnchor valueInBounds: aBounds) cull: self element
]
