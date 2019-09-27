Class {
	#name : #BlBenchmarkConsoleSpecModel,
	#superclass : #ComposableModel,
	#instVars : [
		'fpsLabel',
		'renderTimeLabel',
		'layoutTimeLabel',
		'eventTimeLabel',
		'fps',
		'renderTime',
		'layoutTime',
		'eventTime',
		'space'
	],
	#category : 'Bloc-DevTool'
}

{ #category : #'as yet unclassified' }
BlBenchmarkConsoleSpecModel class >> defaultSpec [
	<spec: #default>
	^ SpecRowLayout composed
		newColumn: [ :col | 
			col
				add: #fpsLabel;
				add: #renderTimeLabel;
				add: #layoutTimeLabel;
				add: #eventTimeLabel ] width:200;
		newColumn: [ :col | 
			col
				add: #fps;
				add: #renderTime;
				add: #layoutTime;
				add: #eventTime ] width:50
]

{ #category : #'as yet unclassified' }
BlBenchmarkConsoleSpecModel class >> onSpace: aSpace [
	^ self basicNew
		space: aSpace;
		initialize;
		openWithSpec
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> eventTime [
	^ eventTime
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> eventTime: anObject [
	eventTime := anObject
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> eventTimeLabel [
	^ eventTimeLabel
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> eventTimeLabel: anObject [
	eventTimeLabel := anObject
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> fps [
	^ fps
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> fps: anObject [
	fps := anObject
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> fpsLabel [
	^ fpsLabel
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> fpsLabel: anObject [
	fpsLabel := anObject
]

{ #category : #initialization }
BlBenchmarkConsoleSpecModel >> initializePresenter [
	| lastTime |
	lastTime := 0.
	space eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceRenderEndEvent do: [ :evt | 
					self renderTime label: (evt end - evt start) asString.
					self fps label: (1000/((evt end - lastTime) max: 1)) ceiling asString.
					lastTime := evt end.
					  ]).
	space eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceEventEndEvent do: [ :evt | 
					self eventTime label: (evt end - evt start) asString. 
					  ]).
  	space eventDispatcher addEventHandler: 
		(BlEventHandler on: BlSpaceLayoutEndEvent do: [ :evt | 
					self layoutTime label: (evt end - evt start) asString. 
					  ])
]

{ #category : #'as yet unclassified' }
BlBenchmarkConsoleSpecModel >> initializeWidgets [
	self title: 'Bloc Dev Tool'.
	fpsLabel := self newLabel label:'FPS (frame/s):'.
	layoutTimeLabel := self newLabel label:'LAYOUT PROCESSING (ms):'.
	renderTimeLabel := self newLabel label:'RENDER PROCESSING (ms):'.
	eventTimeLabel := self newLabel label:'EVENT PROCESSING (ms):'.
	
	fps := self newLabel.
	layoutTime := self newLabel.
	renderTime := self newLabel.
	eventTime := self newLabel.
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> layoutTime [
	^ layoutTime
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> layoutTime: anObject [
	layoutTime := anObject
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> layoutTimeLabel [
	^ layoutTimeLabel
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> layoutTimeLabel: anObject [
	layoutTimeLabel := anObject
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> renderTime [
	^ renderTime
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> renderTime: anObject [
	renderTime := anObject
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> renderTimeLabel [
	^ renderTimeLabel
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> renderTimeLabel: anObject [
	renderTimeLabel := anObject
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> space [
	^ space
]

{ #category : #accessing }
BlBenchmarkConsoleSpecModel >> space: anObject [
	space := anObject
]
