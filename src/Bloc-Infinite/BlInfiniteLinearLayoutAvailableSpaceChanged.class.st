Class {
	#name : 'BlInfiniteLinearLayoutAvailableSpaceChanged',
	#superclass : 'BlInfiniteLinearLayoutAnnouncements',
	#instVars : [
		'availableSpace'
	],
	#category : 'Bloc-Infinite-Layout-Linear',
	#package : 'Bloc-Infinite',
	#tag : 'Layout-Linear'
}

{ #category : 'accessing' }
BlInfiniteLinearLayoutAvailableSpaceChanged >> availableSpace [
	<return: #Number>

	^ availableSpace
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutAvailableSpaceChanged >> availableSpace: aNumber [
	availableSpace := aNumber
]
