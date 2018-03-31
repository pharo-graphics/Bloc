updating
updateOn: aSplineOverScroller
	<return: #Boolean>
	| aCurrentTime anElapsedTime aDuration |

	aCurrentTime := aSplineOverScroller time now.

	anElapsedTime := aCurrentTime - aSplineOverScroller startTime.
	aDuration := aSplineOverScroller duration.

	anElapsedTime < aDuration
		ifTrue: [ 
			| anInterpolatedTime anInterpolatedTranslation aNewPosition |
			
			anInterpolatedTime := self interpolator interpolate: (anElapsedTime / aDuration) asFloat.			
			anInterpolatedTranslation := anInterpolatedTime * (aSplineOverScroller finalPosition - aSplineOverScroller startPosition).
			aNewPosition := aSplineOverScroller startPosition + anInterpolatedTranslation.
			
			aSplineOverScroller currentPosition: aNewPosition ].
		
	^ anElapsedTime < aDuration