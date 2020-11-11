Class {
	#name : #BlExampleEventsCountingElement,
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
		'blurCount'
	],
	#category : #'Bloc-Examples-Event'
}

{ #category : #accessing }
BlExampleEventsCountingElement >> blurCount [
	^ blurCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> blurCount: anObject [
	blurCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> clickCount [
	^ clickCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> clickCount: anObject [
	clickCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dragCount [
	^ dragCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dragCount: anObject [
	dragCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dragEndCount [
	^ dragEndCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dragEndCount: anObject [
	dragEndCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dragEnterCount [
	^ dragEnterCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dragEnterCount: anObject [
	dragEnterCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dragLeaveCount [
	^ dragLeaveCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dragLeaveCount: anObject [
	dragLeaveCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dragStartCount [
	^ dragStartCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dragStartCount: anObject [
	dragStartCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dropCount [
	^ dropCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> dropCount: anObject [
	dropCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> focusCount [
	^ focusCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> focusCount: anObject [
	focusCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> focusInCount [
	^ focusInCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> focusInCount: anObject [
	focusInCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> focusOutCount [
	^ focusOutCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> focusOutCount: anObject [
	focusOutCount := anObject
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementBlurCount [
	blurCount := blurCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementClickCount [
	clickCount := clickCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementDragCount [
	dragCount := dragCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementDragEndCount [
	dragEndCount := dragEndCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementDragEnterCount [
	dragEnterCount := dragEnterCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementDragLeaveCount [
	dragEnterCount := dragLeaveCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementDragStartCount [
	dragStartCount := dragStartCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementDropCount [
	dropCount := dropCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementFocusCount [
	focusCount := focusCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementFocusInCount [
	focusInCount := focusInCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementFocusOutCount [
	focusOutCount := focusOutCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementMouseDownCount [
	mouseDownCount := mouseDownCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementMouseEnterCount [
	mouseEnterCount := mouseEnterCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementMouseLeaveCount [
	mouseLeaveCount := mouseLeaveCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementMouseMoveCount [
	mouseMoveCount := mouseMoveCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementMouseOutCount [
	mouseOutCount := mouseOutCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementMouseOverCount [
	mouseOverCount := mouseOverCount + 1
]

{ #category : #increment }
BlExampleEventsCountingElement >> incrementMouseUpCount [
	mouseUpCount := mouseUpCount + 1
]

{ #category : #initialization }
BlExampleEventsCountingElement >> initialize [
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
	
	self when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementClickCount ].
	
	self when: BlMouseEnterEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementMouseEnterCount ].
	
	self when: BlMouseLeaveEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementMouseLeaveCount ].
	
	self when: BlMouseMoveEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementMouseMoveCount ].
	
	self when: BlMouseOverEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementMouseOverCount ].
	
	self when: BlMouseOutEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementMouseOutCount ].
	
	self when: BlMouseDownEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementMouseDownCount ].
	
	self when: BlMouseUpEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementMouseUpCount ].
	
	self when: BlDragStartEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementDragStartCount ].
	
	self when: BlDragEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementDragCount ].
	
	self when: BlDragEndEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementDragEndCount ].
	
	self when: BlDragEnterEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementDragEnterCount ].
	
	self when: BlDragLeaveEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementDragLeaveCount ].
	
	self when: BlDropEvent do: [ :anEvent |
		anEvent consumed: true.
		anEvent currentTarget incrementDropCount ].
	
	self when: BlFocusInEvent do: [ :anEvent |
		anEvent currentTarget incrementFocusInCount ].
	
	self when: BlFocusOutEvent do: [ :anEvent |
		anEvent currentTarget incrementFocusOutCount ].
	
	self when: BlFocusEvent do: [ :anEvent |
		anEvent currentTarget incrementFocusCount ].
	
	self when: BlBlurEvent do: [ :anEvent |
		anEvent currentTarget incrementBlurCount ].
	
	self addEventHandler: BlPullHandler new.
	
	self background: Color veryVeryLightGray
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseDownCount [
	^ mouseDownCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseDownCount: anObject [
	mouseDownCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseEnterCount [
	^ mouseEnterCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseEnterCount: anObject [
	mouseEnterCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseLeaveCount [
	^ mouseLeaveCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseLeaveCount: anObject [
	mouseLeaveCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseMoveCount [
	^ mouseMoveCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseMoveCount: anObject [
	mouseMoveCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseOutCount [
	^ mouseOutCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseOutCount: anObject [
	mouseOutCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseOverCount [
	^ mouseOverCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseOverCount: anObject [
	mouseOverCount := anObject
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseUpCount [
	^ mouseUpCount
]

{ #category : #accessing }
BlExampleEventsCountingElement >> mouseUpCount: anObject [
	mouseUpCount := anObject
]
