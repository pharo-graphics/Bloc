Class {
	#name : #BlScalableElementExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Scalable-Examples'
}

{ #category : #'examples - instance creation' }
BlScalableElementExamples >> contentElement [

	^ BlElement new
		background: ((BlLinearGradientPaint direction: 1@1) stops: {
			0 -> Color blue.
			1 -> Color red });
		yourself
]

{ #category : #'examples - instance creation' }
BlScalableElementExamples >> contentElementLarger [

	^ self contentElement
		size: self contentExtentLarger;
		yourself
]

{ #category : #'examples - instance creation' }
BlScalableElementExamples >> contentElementMatchingParent [

	^ self contentElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #'examples - instance creation' }
BlScalableElementExamples >> contentElementSmaller [

	^ self contentElement
		size: self contentExtentSmaller;
		yourself
]

{ #category : #accessing }
BlScalableElementExamples >> contentExtentDifference [

	^ 200 @ 100
]

{ #category : #accessing }
BlScalableElementExamples >> contentExtentLarger [

	^ self scalableExtent + self contentExtentDifference
]

{ #category : #accessing }
BlScalableElementExamples >> contentExtentSmaller [

	^ self scalableExtent - self contentExtentDifference
]

{ #category : #'examples - scalable' }
BlScalableElementExamples >> exactContentLargerInExactScalableFitAll [
	<gtExample>

	| aScalable aContent |
	aScalable := self scalableElement.
	aContent := self contentElementLarger.

	aScalable addChild: aContent.
	aScalable forceLayout.

	self assert: aScalable measureScale equals: (3 / 4) asFloat.
	self assert: aScalable extent equals: self scalableExtent.
	self assert: aScalable position equals: 0@0.

	self assert: aContent position equals: (-100.0@ -50.0).
	self assert: aContent extent equals: self contentExtentLarger.
	self assert: aContent bounds transformed asRectangle equals: ((100.0@62.5) corner: (700.0@437.5)).

	^ aScalable
]

{ #category : #'examples - scalable' }
BlScalableElementExamples >> exactContentLargerInFitContentScalableFitAll [
	<gtExample>

	| aScalable aContent |
	aScalable := self scalableElementFitContent.
	aContent := self contentElementLarger.

	aScalable addChild: aContent.
	aScalable forceLayout.

	self assert: aScalable measureScale equals: 1.
	self assert: aScalable extent equals: self contentExtentLarger.
	self assert: aScalable position equals: 0@0.

	self assert: aContent position equals: 0@0.
	self assert: aContent extent equals: self contentExtentLarger.
	self assert: aContent bounds transformed asRectangle equals: (0@0 extent: self contentExtentLarger).

	^ aScalable
]

{ #category : #'examples - scalable' }
BlScalableElementExamples >> exactContentSmallerInExactScalableFitAll [
	<gtExample>

	| aScalable aContent |
	aScalable := self scalableElement.
	aContent := self contentElementSmaller.
	
	aScalable addChild: aContent.
	aScalable forceLayout.

	self assert: aScalable measureScale equals: (4 / 3) asFloat.
	self assert: aScalable extent equals: self scalableExtent.
	self assert: aScalable position equals: 0@0.

	self assert: aContent position equals: 100.0 @ 50.0.
	self assert: aContent extent equals: self contentExtentSmaller.
	self assert: aContent bounds transformed position closeTo: -66.66666666666663 @ -50.0.
	self assert: aContent bounds transformed extent closeTo: 533.3333333333333 @ 400.0.
	
	^ aScalable
]

{ #category : #'examples - scalable' }
BlScalableElementExamples >> matchParentContentInExactScalableFitAll [
	<gtExample>

	| aScalable aContent |
	aScalable := self scalableElement.
	aContent := self contentElementMatchingParent.

	aScalable addChild: aContent.
	aScalable forceLayout.

	self assert: aScalable measureScale equals: 1.
	self assert: aScalable extent equals: self scalableExtent.
	self assert: aScalable position equals: 0@0.

	self assert: aContent position equals: 0@0.
	self assert: aContent extent equals: self scalableExtent.
	self assert: aContent bounds transformed asRectangle equals: (0@0 extent: self scalableExtent).

	^ aScalable
]

{ #category : #'examples - scalable' }
BlScalableElementExamples >> matchParentContentInMatchParentScalableFitAll [
	<gtExample>

	| aScalable aContent aContainer |
	aContainer := BlElement new.
	aContainer size: self scalableExtent.
	
	aScalable := self scalableElement.
	aScalable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	aContent := self contentElementMatchingParent.

	aScalable addChild: aContent.
	aContainer addChild: aScalable.
	
	aContainer forceLayout.

	self assert: aScalable measureScale equals: 1.
	self assert: aScalable extent equals: self scalableExtent.
	self assert: aScalable position equals: 0@0.

	self assert: aContent position equals: 0@0.
	self assert: aContent extent equals: self scalableExtent.
	self assert: aContent bounds transformed asRectangle equals: (0@0 extent: self scalableExtent).

	^ aContainer
]

{ #category : #'examples - instance creation' }
BlScalableElementExamples >> scalableElement [
	<gtExample>

	| aScalableElement |
	aScalableElement := BlScalableElement new.
	aScalableElement size: self scalableExtent.
	aScalableElement border: (BlBorder builder dashed width: 2; paint: Color gray; build).
	
	self assert: aScalableElement hasContentElement not.
	self assert: aScalableElement measureScale equals: 1.0.
	self assert: aScalableElement scaleStrategy equals: BlScalableFitAllStrategy new.

	^ aScalableElement
]

{ #category : #'examples - instance creation' }
BlScalableElementExamples >> scalableElementFitContent [
	<gtExample>

	^ self scalableElement
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		yourself
]

{ #category : #'examples - instance creation' }
BlScalableElementExamples >> scalableElementMatchingParent [
	<gtExample>

	^ self scalableElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #accessing }
BlScalableElementExamples >> scalableExtent [

	^ 600 @ 400
]
