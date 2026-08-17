Class {
	#name : 'BlScalableElementExamples',
	#superclass : 'BlExamplesTest',
	#category : 'Bloc-Scalable-Examples',
	#package : 'Bloc-Scalable-Examples'
}

{ #category : 'examples - instance creation' }
BlScalableElementExamples >> contentElement [

	^ BlElement new
		background: ((BlLinearGradientPaint direction: 1@1) stops: {
			0 -> Color blue.
			1 -> Color red });
		yourself
]

{ #category : 'examples - instance creation' }
BlScalableElementExamples >> contentElementLarger [

	^ self contentElement
		extent: self contentExtentLarger;
		yourself
]

{ #category : 'examples - instance creation' }
BlScalableElementExamples >> contentElementMatchingParent [

	^ self contentElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : 'examples - instance creation' }
BlScalableElementExamples >> contentElementSmaller [

	^ self contentElement
		extent: self contentExtentSmaller;
		yourself
]

{ #category : 'accessing' }
BlScalableElementExamples >> contentExtentDifference [

	^ 200 @ 100
]

{ #category : 'accessing' }
BlScalableElementExamples >> contentExtentLarger [

	^ self scalableExtent + self contentExtentDifference
]

{ #category : 'accessing' }
BlScalableElementExamples >> contentExtentSmaller [

	^ self scalableExtent - self contentExtentDifference
]

{ #category : 'examples - scalable' }
BlScalableElementExamples >> exactContentLargerInExactScalableFitAll [

	<gtExample>
	| aScalable aContent spacedvcj0stcd4qmsft1x9quhn8gk |
	aScalable := self scalableElement.
	aContent := self contentElementLarger.

	aScalable addChild: aContent.
	spacedvcj0stcd4qmsft1x9quhn8gk := BlSpace new host:
		                                  BlHeadlessHost new.
	spacedvcj0stcd4qmsft1x9quhn8gk
		show;
		waitPendingWork.
	spacedvcj0stcd4qmsft1x9quhn8gk mutateSync: [
		spacedvcj0stcd4qmsft1x9quhn8gk root addChild: aScalable ].

	self assert: aScalable measureScale equals: (3 / 4) asFloat.
	self assert: aScalable extent equals: self scalableExtent.
	self assert: aScalable position equals: 0 @ 0.

	self assert: aContent position equals: -100.0 @ -50.0.
	self assert: aContent extent equals: self contentExtentLarger.
	self
		assert: aContent bounds transformed asRectangle
		equals: (100.0 @ 62.5 corner: 700.0 @ 437.5).

	^ aScalable
]

{ #category : 'examples - scalable' }
BlScalableElementExamples >> exactContentLargerInFitContentScalableFitAll [

	<gtExample>
	| aScalable aContent spacebxcnyc6mt7zzxnq0ubjvlijbv |
	aScalable := self scalableElementFitContent.
	aContent := self contentElementLarger.

	aScalable addChild: aContent.
	spacebxcnyc6mt7zzxnq0ubjvlijbv := BlSpace new host:
		                                  BlHeadlessHost new.
	spacebxcnyc6mt7zzxnq0ubjvlijbv
		show;
		waitPendingWork.
	spacebxcnyc6mt7zzxnq0ubjvlijbv mutateSync: [
		spacebxcnyc6mt7zzxnq0ubjvlijbv root addChild: aScalable ].

	self assert: aScalable measureScale equals: 1.
	self assert: aScalable extent equals: self contentExtentLarger.
	self assert: aScalable position equals: 0 @ 0.

	self assert: aContent position equals: 0 @ 0.
	self assert: aContent extent equals: self contentExtentLarger.
	self
		assert: aContent bounds transformed asRectangle
		equals: (0 @ 0 extent: self contentExtentLarger).

	^ aScalable
]

{ #category : 'examples - scalable' }
BlScalableElementExamples >> exactContentSmallerInExactScalableFitAll [

	<gtExample>
	| aScalable aContent space1y9t0o3ytoe82agrehx4ypriu |
	aScalable := self scalableElement.
	aContent := self contentElementSmaller.

	aScalable addChild: aContent.
	space1y9t0o3ytoe82agrehx4ypriu := BlSpace new host:
		                                  BlHeadlessHost new.
	space1y9t0o3ytoe82agrehx4ypriu
		show;
		waitPendingWork.
	space1y9t0o3ytoe82agrehx4ypriu mutateSync: [
		space1y9t0o3ytoe82agrehx4ypriu root addChild: aScalable ].

	self assert: aScalable measureScale equals: (4 / 3) asFloat.
	self assert: aScalable extent equals: self scalableExtent.
	self assert: aScalable position equals: 0 @ 0.

	self assert: aContent position equals: 100.0 @ 50.0.
	self assert: aContent extent equals: self contentExtentSmaller.
	self
		assert: aContent bounds transformed position
		closeTo: -66.66666666666663 @ -50.0.
	self
		assert: aContent bounds transformed extent
		closeTo: 533.3333333333333 @ 400.0.

	^ aScalable
]

{ #category : 'examples - scalable' }
BlScalableElementExamples >> matchParentContentInExactScalableFitAll [

	<gtExample>
	| aScalable aContent space94azxhqiaj5ygfhnw63d8ifyh |
	aScalable := self scalableElement.
	aContent := self contentElementMatchingParent.

	aScalable addChild: aContent.
	space94azxhqiaj5ygfhnw63d8ifyh := BlSpace new host:
		                                  BlHeadlessHost new.
	space94azxhqiaj5ygfhnw63d8ifyh
		show;
		waitPendingWork.
	space94azxhqiaj5ygfhnw63d8ifyh mutateSync: [
		space94azxhqiaj5ygfhnw63d8ifyh root addChild: aScalable ].

	self assert: aScalable measureScale equals: 1.
	self assert: aScalable extent equals: self scalableExtent.
	self assert: aScalable position equals: 0 @ 0.

	self assert: aContent position equals: 0 @ 0.
	self assert: aContent extent equals: self scalableExtent.
	self
		assert: aContent bounds transformed asRectangle
		equals: (0 @ 0 extent: self scalableExtent).

	^ aScalable
]

{ #category : 'examples - scalable' }
BlScalableElementExamples >> matchParentContentInMatchParentScalableFitAll [

	<gtExample>
	| aScalable aContent aContainer space296766ctiydwfssxxv5a8dyz |
	aContainer := BlElement new.
	aContainer extent: self scalableExtent.

	aScalable := self scalableElement.
	aScalable constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	aContent := self contentElementMatchingParent.

	aScalable addChild: aContent.
	aContainer addChild: aScalable.
	space296766ctiydwfssxxv5a8dyz := BlSpace new host: BlHeadlessHost new.
	space296766ctiydwfssxxv5a8dyz
		show;
		waitPendingWork.
	space296766ctiydwfssxxv5a8dyz mutateSync: [
		space296766ctiydwfssxxv5a8dyz root addChild: aContainer ].

	self assert: aScalable measureScale equals: 1.
	self assert: aScalable extent equals: self scalableExtent.
	self assert: aScalable position equals: 0 @ 0.

	self assert: aContent position equals: 0 @ 0.
	self assert: aContent extent equals: self scalableExtent.
	self
		assert: aContent bounds transformed asRectangle
		equals: (0 @ 0 extent: self scalableExtent).

	^ aContainer
]

{ #category : 'examples - instance creation' }
BlScalableElementExamples >> scalableElement [
	<gtExample>

	| aScalableElement |
	aScalableElement := BlScalableElement new.
	aScalableElement extent: self scalableExtent.
	aScalableElement border: (BlBorder builder dashed width: 2; paint: Color gray; build).
	
	self assert: aScalableElement hasContentElement not.
	self assert: aScalableElement measureScale equals: 1.0.
	self assert: aScalableElement scaleStrategy equals: BlScalableFitAllStrategy new.

	^ aScalableElement
]

{ #category : 'examples - instance creation' }
BlScalableElementExamples >> scalableElementFitContent [
	<gtExample>

	^ self scalableElement
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		yourself
]

{ #category : 'examples - instance creation' }
BlScalableElementExamples >> scalableElementMatchingParent [
	<gtExample>

	^ self scalableElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : 'accessing' }
BlScalableElementExamples >> scalableExtent [

	^ 600 @ 400
]
