Class {
	#name : #BlSplineOverScrollerCubicStep,
	#superclass : #BlSplineOverScrollerStep,
	#category : 'Bloc-Utilities - Scrolling Helpers'
}

{ #category : #hooks }
BlSplineOverScrollerCubicStep >> onFinished: aSplineOverScroller [
	"Cubic means no spring back, simply finish"
	<return: #Boolean>
	
	^ false
]
