Class {
	#name : #BlSmoothScroller,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
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

{ #category : #'api - testing' }
BlSmoothScroller >> isPendingInitialRun [
	^ pendingInitialRun
]

{ #category : #'api - testing' }
BlSmoothScroller >> isRunning [
	^ isRunning
]

{ #category : #'api - scrolling' }
BlSmoothScroller >> scrollBy: aPoint [
	self subclassResponsibility
]
