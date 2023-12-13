Class {
	#name : 'BlInfiniteLinearLayoutItemDirection',
	#superclass : 'Object',
	#classInstVars : [
		'head',
		'tail'
	],
	#category : 'Bloc-Infinite-Layout-Linear-Support',
	#package : 'Bloc-Infinite',
	#tag : 'Layout-Linear-Support'
}

{ #category : 'cleanup' }
BlInfiniteLinearLayoutItemDirection class >> cleanUp [
	super cleanUp.
	
	tail := nil.
	head := nil
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutItemDirection class >> head [
	^ head ifNil: [ head := BlInfiniteLinearLayoutItemDirectionHead new ]
]

{ #category : 'accessing' }
BlInfiniteLinearLayoutItemDirection class >> tail [
	^ tail ifNil: [ tail := BlInfiniteLinearLayoutItemDirectionTail new ]
]

{ #category : 'converting' }
BlInfiniteLinearLayoutItemDirection >> multiplier [
	<return: #Number>
	^ self subclassResponsibility
]
