Class {
	#name : #BlSmoothScroller,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'isRunning',
		'pendingInitialRun'
	],
	#category : #'Bloc-Utilities - Scrolling'
}

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
