Class {
	#name : #BlVisibilityProperty,
	#superclass : #BlObjectProperty,
	#category : 'Bloc-Property'
}

{ #category : #'change management' }
BlVisibilityProperty >> invalidated [
	self owner
		requestLayout;
		invalidate
]
