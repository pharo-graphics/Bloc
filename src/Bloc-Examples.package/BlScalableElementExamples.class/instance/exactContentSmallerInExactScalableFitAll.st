examples - scalable
exactContentSmallerInExactScalableFitAll
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