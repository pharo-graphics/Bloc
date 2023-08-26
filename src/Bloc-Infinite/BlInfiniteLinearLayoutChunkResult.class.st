Class {
	#name : #BlInfiniteLinearLayoutChunkResult,
	#superclass : #Object,
	#instVars : [
		'finished',
		'ignoreConsumed',
		'focusable',
		'consumedSpace'
	],
	#category : #'Bloc-Infinite-Layout-Linear-Support'
}

{ #category : #accessing }
BlInfiniteLinearLayoutChunkResult >> consumedSpace [
	<return: #Number>

	^ consumedSpace
]

{ #category : #accessing }
BlInfiniteLinearLayoutChunkResult >> consumedSpace: aNumber [
	consumedSpace := aNumber
]

{ #category : #accessing }
BlInfiniteLinearLayoutChunkResult >> finished [
	<return: #Boolean>

	^ finished
]

{ #category : #accessing }
BlInfiniteLinearLayoutChunkResult >> finished: aBoolean [
	finished := aBoolean
]

{ #category : #accessing }
BlInfiniteLinearLayoutChunkResult >> focusable [
	^ focusable
]

{ #category : #accessing }
BlInfiniteLinearLayoutChunkResult >> focusable: aBoolean [
	focusable := aBoolean
]

{ #category : #accessing }
BlInfiniteLinearLayoutChunkResult >> ignoreConsumed [
	^ ignoreConsumed
]

{ #category : #accessing }
BlInfiniteLinearLayoutChunkResult >> ignoreConsumed: aBoolean [
	ignoreConsumed := aBoolean
]

{ #category : #initialization }
BlInfiniteLinearLayoutChunkResult >> initialize [
	super initialize.
	
	self reset
]

{ #category : #accessing }
BlInfiniteLinearLayoutChunkResult >> reset [
	consumedSpace := 0.
	finished := false.
	ignoreConsumed := false.
	focusable := false
]
