Class {
	#name : #BlInfiniteMouseScrollListener,
	#superclass : #BlBasicEventHandler,
	#category : 'Bloc-Infinite-Basic'
}

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> canScrollDown: anInfiniteElement [
	"Return true if an infinite element can be scrolled down"
	<return: #Boolean>	
	| aLastChild |
	
	aLastChild := anInfiniteElement layout childAtPosition: anInfiniteElement layout itemCount.
	aLastChild
		ifNil: [ ^ true ].

	aLastChild bounds inParent bottom > (anInfiniteElement layout height - anInfiniteElement layout paddingBottom) 
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> canScrollUp: anInfiniteElement [
	"Return true if an infinite element can be scrolled up"
	<return: #Boolean>	
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
BlInfiniteMouseScrollListener >> scrollEvent: anEvent [
	| dX dY anAmount anInfiniteElement didFling |
	
	anAmount := 300.
	
	anInfiniteElement := anEvent currentTarget.

	dX := anEvent isHorizontal
		ifTrue: [ anAmount * anEvent vector x sign ]
		ifFalse: [ 0 ].

	dY := (anEvent isScrollDown and: [ self canScrollDown: anInfiniteElement ])
		ifTrue: [ anAmount ]
		ifFalse: [ (anEvent isScrollUp and: [ self canScrollUp: anInfiniteElement ])
			ifTrue: [ anAmount negated ]
			ifFalse: [ 0 ] ].

	didFling := anEvent currentTarget fling: dX @ dY.
	anEvent consumed: didFling
]

{ #category : #events }
BlInfiniteMouseScrollListener >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
