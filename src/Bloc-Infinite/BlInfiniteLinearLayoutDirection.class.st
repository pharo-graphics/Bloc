Class {
	#name : 'BlInfiniteLinearLayoutDirection',
	#superclass : 'Object',
	#classInstVars : [
		'start',
		'end'
	],
	#category : 'Bloc-Infinite-Layout-Linear-Support',
	#package : 'Bloc-Infinite',
	#tag : 'Layout-Linear-Support'
}

{ #category : 'accessing' }
BlInfiniteLinearLayoutDirection class >> cleanUp [
	super cleanUp.
	
	start := nil.
	end := nil
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutDirection class >> end [
	^ end ifNil: [ end := BlInfiniteLinearLayoutDirectionEnd new ]
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutDirection class >> start [
	^ start ifNil: [ start := BlInfiniteLinearLayoutDirectionStart new ]
]

{ #category : 'testing' }
BlInfiniteLinearLayoutDirection >> isEnd [
	^ self subclassResponsibility
]

{ #category : 'testing' }
BlInfiniteLinearLayoutDirection >> isStart [
	^ self subclassResponsibility
]

{ #category : 'converting' }
BlInfiniteLinearLayoutDirection >> multiplier [
	<return: #Number>
	^ self subclassResponsibility
]
