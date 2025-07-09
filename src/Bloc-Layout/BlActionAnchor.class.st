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

{ #category : #applying }
BlActionAnchor >> checkInParent: anElement forChild: aChild [

	baseAnchor checkInParent: anElement forChild: aChild
]

{ #category : #accessing }
BlActionAnchor >> element [

	^ baseAnchor element
]

{ #category : #initialization }
BlActionAnchor >> initialize [ 

	super initialize.
	baseAnchor := BlNeutralAnchor new
]

{ #category : #applying }
BlActionAnchor >> valueInBounds: aBounds [

	^ action cull: (baseAnchor valueInBounds: aBounds) cull: self element
]
