"
I'm a cubic `BlScrollFlinger` step.
"
Class {
	#name : #BlSplineOverScrollerCubicStep,
	#superclass : #BlSplineOverScrollerStep,
	#category : #'Bloc-Infinite-Scrollable-Helpers'
}

{ #category : #hooks }
BlSplineOverScrollerCubicStep >> onFinished: aSplineOverScroller [
	"Cubic means no spring back, simply finish"
	
	^ false
]
