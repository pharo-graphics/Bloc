Class {
	#name : #BlElementExpandedStateEventHandler,
	#superclass : #BlElementStateEventHandler,
	#category : #'Bloc-Basic-State'
}

{ #category : #private }
BlElementExpandedStateEventHandler >> element: anElement expanded: aBoolean [
	aBoolean
		ifTrue: [ anElement states addState: BlElementState expanded ]
		ifFalse: [ anElement states addState: BlElementState collapsed ]
]

{ #category : #'api - accessing' }
BlElementExpandedStateEventHandler >> eventsToHandle [
	^ {
		BrExpansionToggleWish.
	}
]

{ #category : #'focus handlers' }
BlElementExpandedStateEventHandler >> handleEvent: aBrExpansionToggleWish [
	| anElement |
	
	aBrExpansionToggleWish consumed: true.
	
	anElement := aBrExpansionToggleWish currentTarget.
	self
		element: anElement
		expanded: (anElement states hasState: BlElementState expanded) not
]
