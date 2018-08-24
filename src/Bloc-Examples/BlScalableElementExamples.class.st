Class {
	#name : #BlScalableElementExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Scalable/Pannable'
}

{ #category : #'examples - instance creation' }
BlScalableElementExamples >> contentElement [
	<gtExample>

	^ BlElement new
		background: ((BlLinearGradientPaint direction: 1@1) stops: {
			0 -> Color blue.
			1 -> Color red
		})
]

{ #category : #'examples - instance creation' }
BlScalableElementExamples >> contentElementLarger [
	<gtExample>

	^ self contentElement
		size: self contentExtentLarger
]

{ #category : #'examples - instance creation' }
BlScalableElementExamples >> contentElementSmaller [
	<gtExample>

	^ self contentElement
		size: self contentExtentSmaller
]

{ #category : #accessing }
BlScalableElementExamples >> contentExtentDifference [
	^ 200@100
]

{ #category : #accessing }
BlScalableElementExamples >> contentExtentEqual [
	^ self scalableExtent
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

	aScalable contentElement: aContent.
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
BlScalableElementExamples >> exactContentSmallerInExactScalableFitAll [
	<gtExample>
	| aScalable aContent |
	
	aScalable := self scalableElement.
	aContent := self contentElementSmaller.
	
	aScalable contentElement: aContent.
	aScalable forceLayout.

	self assert: aScalable measureScale equals: (4 / 3) asFloat.
	self assert: aScalable extent equals: self scalableExtent.
	self assert: aScalable position equals: 0@0.

	self assert: aContent position equals: (100.0@ 50.0).
	self assert: aContent extent equals: self contentExtentSmaller.
	self assert: (aContent bounds transformed position closeTo: (-66.66666@ -50.0)).
	self assert: (aContent bounds transformed extent closeTo: (533.333333@400.0)).
	
	^ aScalable
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

{ #category : #accessing }
BlScalableElementExamples >> scalableExtent [
	^ 600 @ 400
]
