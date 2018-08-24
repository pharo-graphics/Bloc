"
Is sent when available space changes in linear layout state
"
Class {
	#name : #BlInfiniteLinearLayoutAvailableSpaceChanged,
	#superclass : #BlInfiniteLinearLayoutAnnouncements,
	#instVars : [
		'availableSpace'
	],
	#category : 'Bloc-Infinite-Layouts-Linear'
}

{ #category : #accessing }
BlInfiniteLinearLayoutAvailableSpaceChanged >> availableSpace [
	<return: #Number>

	^ availableSpace
]

{ #category : #accessing }
BlInfiniteLinearLayoutAvailableSpaceChanged >> availableSpace: aNumber [
	availableSpace := aNumber
]
