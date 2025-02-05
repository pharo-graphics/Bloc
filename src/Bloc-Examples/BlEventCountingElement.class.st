Class {
	#name : #BlEventCountingElement,
	#superclass : #BlElement,
	#instVars : [
		'clickCount',
		'mouseDownCount',
		'mouseUpCount',
		'dragStartCount',
		'dragCount',
		'dragEndCount',
		'mouseEnterCount',
		'mouseLeaveCount',
		'mouseMoveCount',
		'mouseOverCount',
		'mouseOutCount',
		'dropCount',
		'dragEnterCount',
		'dragLeaveCount',
		'focusInCount',
		'focusOutCount',
		'focusCount',
		'blurCount',
		'positionInSpaceChangedCount'
	],
	#category : #'Bloc-Examples-Event'
}

{ #category : #accessing }
BlEventCountingElement >> blurCount [
	^ blurCount
]

{ #category : #accessing }
BlEventCountingElement >> blurCount: anObject [
	blurCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> clickCount [
	^ clickCount
]

{ #category : #accessing }
BlEventCountingElement >> clickCount: anObject [
	clickCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> dragCount [
	^ dragCount
]

{ #category : #accessing }
BlEventCountingElement >> dragCount: anObject [
	dragCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> dragEndCount [
	^ dragEndCount
]

{ #category : #accessing }
BlEventCountingElement >> dragEndCount: anObject [
	dragEndCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> dragEnterCount [
	^ dragEnterCount
]

{ #category : #accessing }
BlEventCountingElement >> dragEnterCount: anObject [
	dragEnterCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> dragLeaveCount [
	^ dragLeaveCount
]

{ #category : #accessing }
BlEventCountingElement >> dragLeaveCount: anObject [
	dragLeaveCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> dragStartCount [
	^ dragStartCount
]

{ #category : #accessing }
BlEventCountingElement >> dragStartCount: anObject [
	dragStartCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> dropCount [
	^ dropCount
]

{ #category : #accessing }
BlEventCountingElement >> dropCount: anObject [
	dropCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> focusCount [
	^ focusCount
]

{ #category : #accessing }
BlEventCountingElement >> focusCount: anObject [
	focusCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> focusInCount [
	^ focusInCount
]

{ #category : #accessing }
BlEventCountingElement >> focusInCount: anObject [
	focusInCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> focusOutCount [
	^ focusOutCount
]

{ #category : #accessing }
BlEventCountingElement >> focusOutCount: anObject [
	focusOutCount := anObject
]

{ #category : #increment }
BlEventCountingElement >> incrementBlurCount [
	blurCount := blurCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementClickCount [
	clickCount := clickCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementDragCount [
	dragCount := dragCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementDragEndCount [
	dragEndCount := dragEndCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementDragEnterCount [
	dragEnterCount := dragEnterCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementDragLeaveCount [
	dragEnterCount := dragLeaveCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementDragStartCount [
	dragStartCount := dragStartCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementDropCount [
	dropCount := dropCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementFocusCount [
	focusCount := focusCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementFocusInCount [
	focusInCount := focusInCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementFocusOutCount [
	focusOutCount := focusOutCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementMouseDownCount [
	mouseDownCount := mouseDownCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementMouseEnterCount [
	mouseEnterCount := mouseEnterCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementMouseLeaveCount [
	mouseLeaveCount := mouseLeaveCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementMouseMoveCount [
	mouseMoveCount := mouseMoveCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementMouseOutCount [
	mouseOutCount := mouseOutCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementMouseOverCount [
	mouseOverCount := mouseOverCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementMouseUpCount [
	mouseUpCount := mouseUpCount + 1
]

{ #category : #increment }
BlEventCountingElement >> incrementPositionInSpaceChangedCount [
	positionInSpaceChangedCount := positionInSpaceChangedCount + 1
]

{ #category : #initialization }
BlEventCountingElement >> initialize [

	super initialize.

	clickCount := 0.
	mouseDownCount := 0.
	mouseEnterCount := 0.
	mouseOverCount := 0.
	mouseOutCount := 0.
	mouseLeaveCount := 0.
	mouseUpCount := 0.
	mouseMoveCount := 0.
	dragStartCount := 0.
	dragCount := 0.
	dragEndCount := 0.
	dragEnterCount := 0.
	dragLeaveCount := 0.
	dropCount := 0.
	focusInCount := 0.
	focusOutCount := 0.
	focusCount := 0.
	blurCount := 0.
	positionInSpaceChangedCount := 0.

	self addEventHandler:
		(BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent | anEvent currentTarget incrementClickCount ]).

	self addEventHandler:
		(BlEventHandler
			 on: BlMouseEnterEvent
			 do: [ :anEvent | anEvent currentTarget incrementMouseEnterCount ]).

	self addEventHandler:
		(BlEventHandler
			 on: BlMouseLeaveEvent
			 do: [ :anEvent | anEvent currentTarget incrementMouseLeaveCount ]).

	self addEventHandler:
		(BlEventHandler
			 on: BlMouseMoveEvent
			 do: [ :anEvent | anEvent currentTarget incrementMouseMoveCount ]).

	self addEventHandler:
		(BlEventHandler
			 on: BlMouseOverEvent
			 do: [ :anEvent | anEvent currentTarget incrementMouseOverCount ]).

	self addEventHandler:
		(BlEventHandler
			 on: BlMouseOutEvent
			 do: [ :anEvent | anEvent currentTarget incrementMouseOutCount ]).

	self addEventHandler:
		(BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :anEvent | anEvent currentTarget incrementMouseDownCount ]).

	self addEventHandler:
		(BlEventHandler
			 on: BlMouseUpEvent
			 do: [ :anEvent | anEvent currentTarget incrementMouseUpCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlDragStartEvent
			do: [ :anEvent |
				anEvent consume. "Need to consume this event to proceed"
				anEvent currentTarget incrementDragStartCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlDragEvent
			do: [ :anEvent | anEvent currentTarget incrementDragCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlDragEndEvent
			do: [ :anEvent | anEvent currentTarget incrementDragEndCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlDragEnterEvent
			do: [ :anEvent | anEvent currentTarget incrementDragEnterCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlDragLeaveEvent
			do: [ :anEvent | anEvent currentTarget incrementDragLeaveCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlDropEvent
			do: [ :anEvent | anEvent currentTarget incrementDropCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlFocusInEvent
			do: [ :anEvent | anEvent currentTarget incrementFocusInCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlFocusOutEvent
			do: [ :anEvent | anEvent currentTarget incrementFocusOutCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlFocusEvent
			do: [ :anEvent | anEvent currentTarget incrementFocusCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlBlurEvent
			do: [ :anEvent | anEvent currentTarget incrementBlurCount ]).

	self addEventHandler:
		(BlEventHandler
			on: BlElementPositionInSpaceChangedEvent
			do: [ :anEvent |
				anEvent currentTarget incrementPositionInSpaceChangedCount ]).

	self background: Color veryVeryLightGray
]

{ #category : #accessing }
BlEventCountingElement >> mouseDownCount [
	^ mouseDownCount
]

{ #category : #accessing }
BlEventCountingElement >> mouseDownCount: anObject [
	mouseDownCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> mouseEnterCount [
	^ mouseEnterCount
]

{ #category : #accessing }
BlEventCountingElement >> mouseEnterCount: anObject [
	mouseEnterCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> mouseLeaveCount [
	^ mouseLeaveCount
]

{ #category : #accessing }
BlEventCountingElement >> mouseLeaveCount: anObject [
	mouseLeaveCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> mouseMoveCount [
	^ mouseMoveCount
]

{ #category : #accessing }
BlEventCountingElement >> mouseMoveCount: anObject [
	mouseMoveCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> mouseOutCount [
	^ mouseOutCount
]

{ #category : #accessing }
BlEventCountingElement >> mouseOutCount: anObject [
	mouseOutCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> mouseOverCount [
	^ mouseOverCount
]

{ #category : #accessing }
BlEventCountingElement >> mouseOverCount: anObject [
	mouseOverCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> mouseUpCount [
	^ mouseUpCount
]

{ #category : #accessing }
BlEventCountingElement >> mouseUpCount: anObject [
	mouseUpCount := anObject
]

{ #category : #accessing }
BlEventCountingElement >> positionInSpaceChangedCount [
	^ positionInSpaceChangedCount
]

{ #category : #accessing }
BlEventCountingElement >> positionInSpaceChangedCount: anObject [
	positionInSpaceChangedCount := anObject
]
