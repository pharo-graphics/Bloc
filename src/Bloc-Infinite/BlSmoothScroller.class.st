Class {
	#name : #BlSmoothScroller,
	#superclass : #Object,
	#instVars : [
		'isRunning',
		'pendingInitialRun'
	],
	#category : #'Bloc-Infinite-Scrollable-Core'
}

{ #category : #initialization }
BlSmoothScroller >> initialize [

	super initialize.

	isRunning := false.
	pendingInitialRun := true
]

{ #category : #testing }
BlSmoothScroller >> isPendingInitialRun [

	^ pendingInitialRun
]

{ #category : #testing }
BlSmoothScroller >> isRunning [

	^ isRunning
]

{ #category : #scrolling }
BlSmoothScroller >> scrollBy: aPoint [

	self subclassResponsibility
]
