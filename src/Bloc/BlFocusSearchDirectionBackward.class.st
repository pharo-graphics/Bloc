Class {
	#name : #BlFocusSearchDirectionBackward,
	#superclass : #BlFocusSearchDirectionRelative,
	#category : #'Bloc-Utilities - Focus'
}

{ #category : #focus }
BlFocusSearchDirectionBackward >> initFocusedBounds: aFocusedBounds root: aFocusRootElement [

	aFocusRootElement layout isRightToLeft
		ifTrue: [ 
			aFocusedBounds
				left: 0
				top: 0
				right: 0
				bottom: 0 ]
		ifFalse: [
			aFocusedBounds
				left: aFocusRootElement width
				top: aFocusRootElement height
				right: aFocusRootElement width
				bottom: aFocusRootElement height ]
]
