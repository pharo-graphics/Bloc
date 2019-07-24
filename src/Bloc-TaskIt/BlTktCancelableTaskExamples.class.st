Class {
	#name : #BlTktCancelableTaskExamples,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #'examples - task execution and ui controls' }
BlTktCancelableTaskExamples >> cancelingTaskExecution [
	<gtExample>
	<noTest>
	| aContainer aStop aProgress aProgressLine aTask aCallback |
	aContainer := self stopAndProgressElements.
	aStop := aContainer childNamed: #stop.
	aProgress := aContainer childNamed: #progress.
	aProgressLine := aProgress childAt: 1.
	aTask := self taskWithNoExplicitExecutionHandling asNotifyingTask.
	aStop addEventHandlerOn: BlClickEvent do: [ :anEvent | 
		aTask terminationRequested.
		anEvent currentTarget background: Color lightRed ].
	aCallback := [ :aNotification :anElement | 
		anElement constraintsDo: [ :c | c frame horizontal weight: aNotification fraction asFloat ] ].
	aTask onNotification: BlExactProgress enqueue: aCallback in: aProgressLine.
	aProgressLine enqueueTask: (BlTaskAction new action: [ BlAsyncUIWorkerPool default schedule: aTask ]).
	^ aContainer
]

{ #category : #'examples - task execution and ui controls' }
BlTktCancelableTaskExamples >> controllingTaskExecution [
	<gtExample>
	<noTest>
	| aContainer aPlay aPause aProgress aProgressLine aTask |
	aContainer := self playPauseAndProgressElement.
	aPlay := aContainer childNamed: #play.
	aPause := aContainer childNamed: #pause.
	aProgress := aContainer childNamed: #progress.
	aProgressLine := aProgress childAt: 1.
	aTask := self taskWithPauseAndResumeFeatures.
	aPlay addEventHandlerOn: BlClickEvent do: [ :anEvent | aTask startOrResumeRequest ].
	aPause addEventHandlerOn: BlClickEvent do: [ :anEvent | aTask pauseRequest ].
	aTask onNotification: BlExactProgress do: [ :aNotification | 
		aProgressLine constraintsDo: [ :c | c frame horizontal weight: aNotification fraction ] ].
	^ aContainer
]

{ #category : #'examples - ui elements' }
BlTktCancelableTaskExamples >> pauseElement [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		layout: (BlGridLayout new cellSpacing: 5);
		geometry: (BlCircle new);
		addChild: self pauseRectangleElement;
		addChild: self pauseRectangleElement;
		border: (BlBorder paint: Color veryLightGray width: 1);
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 3).
			c vertical fitContent.
			c horizontal fitContent.
			c linear vertical alignCenter ];
		addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent | anEvent currentTarget background: Color veryLightGray ];
		addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent | anEvent currentTarget background: Color white ];
		addEventHandlerOn: BlClickEvent do: [ :anEvent | self inform: 'click' ].
	^ anElement 
]

{ #category : #'examples - ui elements' }
BlTktCancelableTaskExamples >> pauseRectangleElement [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		geometry: BlRectangle new;
		background: Color darkGray;
		size: 5@15.
	^ anElement 
]

{ #category : #'examples - ui elements' }
BlTktCancelableTaskExamples >> playElement [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		layout: (BlLinearLayout new);
		geometry: (BlCircle new);
		addChild: self playTriangleElement;
		border: (BlBorder paint: Color veryLightGray width: 1);
		constraintsDo: [ :c | 
			c padding: (BlInsets top: 8 left: 10 bottom: 8 right: 6).
			c vertical fitContent.
			c horizontal fitContent.
			c linear vertical alignCenter ];
		addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent | anEvent currentTarget background: Color veryLightGray ];
		addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent | anEvent currentTarget background: Color white ];
		addEventHandlerOn: BlClickEvent do: [ :anEvent | self inform: 'click' ].
	^ anElement 
]

{ #category : #'examples - ui' }
BlTktCancelableTaskExamples >> playPauseAndProgressElement [
	<gtExample>
	| aContainer |
	aContainer := BlElement new.
	aContainer addChild: self playElement as: #play.
	aContainer addChild: self pauseElement as: #pause.
	aContainer addChild: self progressBar as: #progress.
	aContainer layout: (BlLinearLayout new cellSpacing: 10).
	aContainer constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 5) ].
	^ aContainer
]

{ #category : #'examples - ui elements' }
BlTktCancelableTaskExamples >> playPolygon [
	<gtExample>
	^ BlPolygon vertices: {
		0@0.
		15@7.
		0@15.
		0@0.
	}
]

{ #category : #'examples - ui elements' }
BlTktCancelableTaskExamples >> playTriangleElement [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		geometry: self playPolygon;
		background: Color darkGray;
		size: 15@15.
	^ anElement 
]

{ #category : #'examples - ui elements' }
BlTktCancelableTaskExamples >> progressBar [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		layout: BlFrameLayout new;
		background: Color white;
		border: (BlBorder paint: Color lightGray muchLighter width: 1);
		padding: (BlInsets all: 1);
		size: 200@7;
		addChild: self progressLine;
		constraintsDo: [ :c | 
			c linear vertical alignCenter ].
	^ anElement 
]

{ #category : #'examples - ui elements' }
BlTktCancelableTaskExamples >> progressLine [
	<gtExample>
	| anElement |
	anElement := BlElement new
		background: Color veryLightGray;
		constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignLeft.
			c frame horizontal weight: 0.3.
			c horizontal matchParent.
			c vertical matchParent ].
	^ anElement 
]

{ #category : #'examples - ui' }
BlTktCancelableTaskExamples >> stopAndProgressElements [
	<gtExample>
	| aContainer |
	aContainer := BlElement new.
	aContainer addChild: self stopElement as: #stop.
	aContainer addChild: self progressBar as: #progress.
	aContainer layout: (BlLinearLayout new cellSpacing: 10).
	aContainer constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets all: 5) ].
	^ aContainer
]

{ #category : #'examples - ui elements' }
BlTktCancelableTaskExamples >> stopElement [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		layout: (BlLinearLayout new);
		geometry: (BlCircle new);
		addChild: self stopSquareElement;
		border: (BlBorder paint: Color veryLightGray width: 1);
		constraintsDo: [ :c | 
			c padding: (BlInsets top: 8 left: 8 bottom: 8 right: 8).
			c vertical fitContent.
			c horizontal fitContent.
			c linear vertical alignCenter ];
		addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent | anEvent currentTarget background: Color veryLightGray ];
		addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent | anEvent currentTarget background: Color white ].
	^ anElement 
]

{ #category : #'examples - ui elements' }
BlTktCancelableTaskExamples >> stopSquareElement [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		geometry: BlRectangle new;
		background: Color darkGray;
		size: 15@15.
	^ anElement 
]

{ #category : #'examples - task execution and ui controls' }
BlTktCancelableTaskExamples >> taskWithNoExplicitExecutionHandling [
	<gtExample>
	<noTest>
	^ [ 
		3 seconds wait. 
		1 to: 20 do: [ :each |
			BlExactProgress signal: 'Transferring...' amount: each * 1024 total: 20*1024.
			(Delay forMilliseconds: 300) wait ] ] asTask asNamedTask name: 'Example task with no explicit execution handling'
]
