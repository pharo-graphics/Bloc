Class {
	#name : #BlInfiniteMouseScrollListener,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'restrictedByOrientation'
	],
	#classVars : [
		'ScrollingVelocity'
	],
	#category : #'Bloc-Infinite-Scrollable-Core'
}

{ #category : #accessing }
BlInfiniteMouseScrollListener class >> scrollingVelocity [

	^ ScrollingVelocity ifNil: [ ScrollingVelocity := 40 ]
]

{ #category : #accessing }
BlInfiniteMouseScrollListener class >> scrollingVelocity: anInteger [

	ScrollingVelocity := anInteger
]

{ #category : #settings }
BlInfiniteMouseScrollListener class >> settingsOn: aBuilder [
	<systemsettings>

	(aBuilder range: #scrollingVelocity)
		parent: Bloc groupSymbolForBloc;
		target: self;
		order: 5;
		label: 'Scrolling velocity';
		description:
			'A positive integer used as a multiplier to increase mousewheel scrolling velocity ';
		range: (1 to: 200 by: 1);
		default: OSPlatform current defaultScrollingVelocity
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> canScrollDown: anInfiniteElement [
	"Return true if an infinite element can be scrolled down"
	<return: #Boolean>	
	| aLastChild |
	
	aLastChild := anInfiniteElement layout childAtPosition: anInfiniteElement layout itemCount.
	aLastChild
		ifNil: [ ^ true ].

	aLastChild bounds inParent bottom > (anInfiniteElement height - anInfiniteElement layout paddingBottom) 
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> canScrollUp: anInfiniteElement [
	"Return true if an infinite element can be scrolled up"
	
	| aFirstChild |

	aFirstChild := anInfiniteElement layout childAtPosition: 1.
	aFirstChild
		ifNil: [ ^ true ].
		
	aFirstChild position y < (anInfiniteElement layout paddingTop) 
		ifTrue: [ ^ true ].
		
	^ false
]

{ #category : #accessing }
BlInfiniteMouseScrollListener >> eventClass [
	^ BlMouseWheelEvent
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> handleEvent: anEvent [
	anEvent sendTo: self
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> mouseWheelEvent: anEvent [

	| dX dY anInfiniteElement isHorizontal |
	anEvent vector isZero ifTrue: [ ^ self ].

	anEvent currentTarget eventDispatcher wantsScrolledEvent ifFalse: [
		^ self ].

	self restrictedByOrientation ifTrue: [
		anEvent currentTarget layout mouseWheelEvent: anEvent.
		^ self ].

	anInfiniteElement := anEvent currentTarget.

	isHorizontal := anEvent vector x abs > anEvent vector y abs.

	dX := isHorizontal
		      ifTrue: [ anEvent vector length * anEvent vector x sign ]
		      ifFalse: [ 0 ].

	dY := isHorizontal not
		      ifTrue: [ "we are horizontal => no vertical scroll"
			      (anEvent isScrollDown and: [
				       self canScrollDown: anInfiniteElement ])
				      ifTrue: [ anEvent vector length ]
				      ifFalse: [
					      (anEvent isScrollUp and: [
						       self canScrollUp: anInfiniteElement ])
						      ifTrue: [ anEvent vector length negated ]
						      ifFalse: [ 0 ] ] ]
		      ifFalse: [ 0 ].

	anInfiniteElement smoothScrollBy: dX @ dY * self scrollingVelocity.
	anEvent consumed: dY isZero not
]

{ #category : #printing }
BlInfiniteMouseScrollListener >> printOn: aStream [
	aStream 
		nextPutAll: 'Event handler of ';
		print: self eventClass.
]

{ #category : #accessing }
BlInfiniteMouseScrollListener >> restrictedByOrientation [

	^ restrictedByOrientation ifNil: [ restrictedByOrientation := false ]
]

{ #category : #accessing }
BlInfiniteMouseScrollListener >> restrictedByOrientation: aBoolean [

	restrictedByOrientation := aBoolean
]

{ #category : #accessing }
BlInfiniteMouseScrollListener >> scrollingVelocity [

	^ self class scrollingVelocity
]

{ #category : #events }
BlInfiniteMouseScrollListener >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
