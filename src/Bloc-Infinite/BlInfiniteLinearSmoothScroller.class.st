"
I am a SmoothScroller implementation which uses a LinearInterpolator until the target position becomes a child of the InfiniteElement and then uses a DecelerateInterpolator to slowly approach to target position.

"
Class {
	#name : #BlInfiniteLinearSmoothScroller,
	#superclass : #BlInfiniteSmoothScroller,
	#instVars : [
		'targetVector',
		'interimTarget',
		'linearInterpolator',
		'decelerateInterpolator'
	],
	#classVars : [
		'SnapToAny',
		'SnapToEnd',
		'SnapToStart'
	],
	#category : #'Bloc-Infinite-Scroller'
}

{ #category : #'class initialization' }
BlInfiniteLinearSmoothScroller class >> initialize [
	
	SnapToAny := #any.
	SnapToEnd := #end.
	SnapToStart := #start
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> calculateDelta: aViewExtent toFit: aBoxExtent snap: aSnapPreference [

	"view start = aViewExtent x
	view end = aViewExtent y
	box start = aBoxExtent x
	box end = aBoxExtent y"

	aSnapPreference = SnapToStart ifTrue: [
		^ aBoxExtent x - aViewExtent x ].
	
	aSnapPreference = SnapToEnd ifTrue: [
		^ aBoxExtent y - aViewExtent y ].
	
	aSnapPreference = SnapToAny ifTrue: [ 
		| aDeltaStart aDeltaEnd |
		aDeltaStart := aBoxExtent x - aViewExtent x.
		aDeltaStart > 0 ifTrue: [ ^ aDeltaStart ].
		aDeltaEnd := aBoxExtent y - aViewExtent y.
		aDeltaEnd < 0 ifTrue: [ ^ aDeltaEnd ].
		^ 0 ].
	
	self error: 'Unknown snap preference: ', aSnapPreference asString
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> calculateDeltaXToMakeVisible: anElement snap: aSnapPreference [
	"Calculates the horizontal scroll amount necessary to make the given element fully visible"
	<return: #Number>
	| aLayout aConstraints aLeft aRight aStart anEnd |

	aLayout := self layout.

	aLayout canScrollHorizontally
		ifFalse: [ ^ 0 ].
	
	aConstraints := anElement constraints.
	aLeft := (aLayout decoratedLeft: anElement) - aConstraints margin left.
	aRight := (aLayout decoratedRight: anElement) + aConstraints margin right.
	aStart := aLayout paddingLeft.
	anEnd := aLayout width - aLayout paddingRight.
	
	^ self calculateDelta: aLeft @ aRight toFit: aStart @ anEnd snap: aSnapPreference
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> calculateDeltaYToMakeVisible: anElement snap: aSnapPreference [
	"Calculates the vertical scroll amount necessary to make the given element fully visible"
	<return: #Number>
	| aLayout aConstraints aTop aBottom aStart anEnd |

	aLayout := self layout.

	aLayout canScrollVertically
		ifFalse: [ ^ 0 ].
	
	aConstraints := anElement constraints.
	aTop := (aLayout decoratedTop: anElement) - aConstraints margin top.
	aBottom := (aLayout decoratedBottom: anElement) + aConstraints margin bottom.
	aStart := aLayout paddingTop.
	anEnd := aLayout height - aLayout paddingBottom.
	
	^ self calculateDelta: aTop @ aBottom toFit: aStart @ anEnd snap: aSnapPreference
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> calculateSpeedPerPixel [
	"Calculate the time (in ms) it should take for each pixel. For instance,
	if returned value is 2 ms, it means scrolling 1000 pixels with LinearInterpolation should take 2 seconds"
	<return: #Duration>
	| aDpi |

	aDpi := infiniteElement isAttachedToSceneGraph
		ifTrue: [ infiniteElement space densityDpi ]
		"not attached to space, can only guess.."
		ifFalse: [ 96.0 ].
	
	^ self millisecondsPerInch / aDpi
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> calculateTimeForDeceleration: aDistance [
	"Calculates the time for deceleration so that transition from LinearInterpolator to DecelerateInterpolator looks smooth.
	We want to cover same area with the linear interpolator for the first 10% of the interpolation.
	After that, deceleration will take control. Area under curve (1-(1-x)^2) can be calculated as (1 - x/3) * x * x
	which gives 0.100028 when x = 0.3356; this is why we divide linear scrolling time with 0.3356"
	<return: #Number>

	^ (self calculateTimeForScrolling: aDistance) / 0.3356
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> calculateTimeForScrolling: aDistance [
	"Calculates the time it should take to scroll the given distance (in pixels)"
	<return: #Duration>

	^ self millisecondsPerPixel * aDistance abs
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> clampApplyScroll: aTmpDelta to: aDelta [
	<return: #Number>
	| aBefore tmpDt |
	
	aBefore := aTmpDelta.
	tmpDt := aTmpDelta - aDelta.
	
	(aBefore * tmpDt <= 0)
		"changed sign, reached 0 or was 0, reset"
		ifTrue: [ ^ 0 ].
	
	^ tmpDt
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> computeScrollVectorForPosition: aPosition [
	"Compute the scroll vector for a given target position.
	I can return null if the layout cannot calculate a scroll vector for the given position
	(e.g. it has no current scroll position)

	Note, that OBlInfiniteLayout does not implement #computeScrollVectorForPosition: by default,
	that is why you can either subclass me or infinite layout"

	<return: #Point>
	
	^ self layout computeScrollVectorForPosition: aPosition
]

{ #category : #initialization }
BlInfiniteLinearSmoothScroller >> defaultDecelerateInterpolator [
	^ BlDecelerateInterpolator default
]

{ #category : #initialization }
BlInfiniteLinearSmoothScroller >> defaultLinearInterpolator [
	^ BlLinearInterpolator default
]

{ #category : #testing }
BlInfiniteLinearSmoothScroller >> hasTargetVector [
	"Return true if I already know a vector to target element, false otherwise"
	
	^ targetVector isNotNil
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> horizontalSnapPreference [
	"When scrolling towards a child element, I define whether we should
	align the left or the right edge of the child with the parent InfiniteElement"
	<return: #Symbol>

	^ (self hasTargetVector not or: [ self targetVector x isZero ])
		ifTrue: [ SnapToAny ]
		ifFalse: [ self targetVector x > 0
			ifTrue: [ SnapToEnd ]
			ifFalse: [ SnapToStart ] ]
]

{ #category : #initialization }
BlInfiniteLinearSmoothScroller >> initialize [
	super initialize.
	
	interimTarget := 0@0.
	linearInterpolator := self defaultLinearInterpolator.
	decelerateInterpolator := self defaultDecelerateInterpolator
]

{ #category : #accessing }
BlInfiniteLinearSmoothScroller >> millisecondsPerInch [
	<return: #Duration>

	^ 25.0 milliSeconds
]

{ #category : #accessing }
BlInfiniteLinearSmoothScroller >> millisecondsPerPixel [
	<return: #Duration>

	^ self calculateSpeedPerPixel
]

{ #category : #hooks }
BlInfiniteLinearSmoothScroller >> onSeekTargetStep: aDeltaPoint action: aScrollerAction [

	self childrenCount isZero
		ifTrue: [ ^ self stop ].
		
	(targetVector isNotNil and: [
		(targetVector x * aDeltaPoint x) < 0 or: [ 
			(targetVector y * aDeltaPoint y) < 0 ] ])
		ifTrue: [ self error: 'Scroll happened in the opposite direction of the target, check your calculations' ].
	
	interimTarget := (self clampApplyScroll: interimTarget x to: aDeltaPoint x) @ (self clampApplyScroll: interimTarget y to: aDeltaPoint y).
	
	interimTarget isZero
		ifTrue: [ self updateActionForInterimTarget: aScrollerAction ].

	"everything is valid, keep going"
]

{ #category : #hooks }
BlInfiniteLinearSmoothScroller >> onStart [
]

{ #category : #hooks }
BlInfiniteLinearSmoothScroller >> onStop [
	interimTarget := 0@0.
	targetVector := nil
]

{ #category : #hooks }
BlInfiniteLinearSmoothScroller >> onTargetFound: anElement action: aScrollingAction [
	| dX dY aDistance aTime |
	
	dX := self calculateDeltaXToMakeVisible: anElement snap: self horizontalSnapPreference.
	dY := self calculateDeltaYToMakeVisible: anElement snap: self verticalSnapPreference.
	aDistance := ((dX * dX) + (dY * dY)) sqrt.
	aTime := self calculateTimeForDeceleration: aDistance.
	aTime <= 0 seconds
		ifTrue: [ ^ self ].
		
	aScrollingAction
		update: (dX @ dY) negated
		duration: aTime
		interpolator: decelerateInterpolator
]

{ #category : #accessing }
BlInfiniteLinearSmoothScroller >> targetSeekExtraScrollRatio [
	"Trigger a scroll to a further distance than targetSeekScrollDistance so that if target
	element is not laid out until interim target position is reached, we can detect the case before
	scrolling slows down and reschedule another interim target scroll"
	<return: #Number>

	^ 1.2
]

{ #category : #accessing }
BlInfiniteLinearSmoothScroller >> targetSeekScrollDistance [
	^ 10000
]

{ #category : #accessing }
BlInfiniteLinearSmoothScroller >> targetVector [
	"Return a point representing the targetVector"

	^ targetVector
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> updateActionForInterimTarget: aScrollerAction [
	"When the target scroll position is not a child of the InfiniteElement,
	I calculates a direction vector towards that child and trigger a smooth scroll"
	| aScrollVector aTime |
	
	aScrollVector := self computeScrollVectorForPosition: self targetPosition.
	(aScrollVector isNil or: [ aScrollVector x isZero and: [ aScrollVector y isZero ] ])
		ifTrue: [ 
			aScrollerAction jumpTo: self targetPosition.
			self stop.
			^ self ].
		
	aScrollVector := aScrollVector normalized.
	targetVector := aScrollVector.
	
	interimTarget := (self targetSeekScrollDistance * aScrollVector x) @ (self targetSeekScrollDistance * aScrollVector y).
	aTime := self calculateTimeForScrolling: self targetSeekScrollDistance.
	aScrollerAction
		update: interimTarget * self targetSeekExtraScrollRatio
		duration: aTime * self targetSeekExtraScrollRatio
		interpolator: linearInterpolator
]

{ #category : #physics }
BlInfiniteLinearSmoothScroller >> verticalSnapPreference [
	"When scrolling towards a child element, I define whether we should
	align the top or the bottom edge of the child with the parent InfiniteElement"
	<return: #Symbol>

	^ (self hasTargetVector not or: [ self targetVector y isZero ])
		ifTrue: [ SnapToAny ]
		ifFalse: [ self targetVector y > 0
			ifTrue: [ SnapToEnd ]
			ifFalse: [ SnapToStart ] ]
]
