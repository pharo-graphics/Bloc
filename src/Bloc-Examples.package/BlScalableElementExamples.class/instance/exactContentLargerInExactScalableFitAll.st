examples - scalable
exactContentLargerInExactScalableFitAll
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