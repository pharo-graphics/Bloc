Class {
	#name : 'BlSplineOverScrollerCubicStep',
	#superclass : 'BlSplineOverScrollerStep',
	#category : 'Bloc-Infinite-Scrollable-Helpers',
	#package : 'Bloc-Infinite',
	#tag : 'Scrollable-Helpers'
}

{ #category : 'hooks' }
BlSplineOverScrollerCubicStep >> onFinished: aSplineOverScroller [
	"Cubic means no spring back, simply finish"
	<return: #Boolean>
	
	^ false
]
