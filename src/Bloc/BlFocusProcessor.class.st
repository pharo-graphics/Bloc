Class {
	#name : #BlFocusProcessor,
	#superclass : #BlBaseEventProcessor,
	#instVars : [
		'focusOwner',
		'focusChain'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #'event firing' }
BlFocusProcessor >> fireBlurEvent: anElement [
	"Create and send blur event that doesn't bubble, perform simple direct dispatch to the given target element"
	self
		dispatchEvent: (self newBlurEvent target: anElement)
		target: anElement
]

{ #category : #'event firing' }
BlFocusProcessor >> fireFocusEvent: anElement [
	"Send focus event that doesn't bubble, perform simple direct dispatch to the target"
	
	self
		dispatchEvent: (self newFocusEvent target: anElement)
		target: anElement
]

{ #category : #'event firing' }
BlFocusProcessor >> fireFocusInEvent: anElement [
	"Send focusIn event that should bubble"

	self fireEvent: (self newFocusInEvent target: anElement)
]

{ #category : #'event firing' }
BlFocusProcessor >> fireFocusOutEvent: anElement [
	"Send focusOut event that should bubble"

	self fireEvent: (self newFocusOutEvent target: anElement)
]

{ #category : #'event firing' }
BlFocusProcessor >> fireFocusTransferEvent: anElement from: aPreviousFocusedElement [
	"Send focus event that doesn't bubble, perform simple direct dispatch to the target"
	self
		dispatchEvent: (self newFocusTransferEvent
			target: anElement;
			transfer: aPreviousFocusedElement)
		target: anElement
]

{ #category : #accessing }
BlFocusProcessor >> focusOwner [
	^ focusOwner
]

{ #category : #'focus - processing' }
BlFocusProcessor >> handleMouseDown: anEvent [
	"Clicking outside does not mean focus should be lost"
]

{ #category : #testing }
BlFocusProcessor >> hasFocusOwner [
	"Return true if there is an element holding focus, false otherwise.
	When there are no elements interested in focus it is given to the root element.
	Note: focus owner may not exist during space initialization or inbetween blur and focus events"
	<return: #Boolean>

	^ focusOwner isNotNil
]

{ #category : #'focus - requesting' }
BlFocusProcessor >> looseFor: anElement [
	focusOwner ~= anElement
		ifTrue: [ ^ self ].
		
	self processBlur: anElement.
	"don't forget to forget focused element"
	focusOwner := nil
]

{ #category : #'instance creation' }
BlFocusProcessor >> newBlurEvent [
	"Create, initialize and return a blur event that should be sent to the element
	that just lost its focus"
	<return: #BlBlurEvent>

	^ BlBlurEvent new
		canBePropagated: false
]

{ #category : #'instance creation' }
BlFocusProcessor >> newFocusEvent [
	"Create, initialize and return a focus event that should be sent to the element
	after it gets focus"
	<return: #BlFocusEvent>

	^ BlFocusEvent new
		canBePropagated: false
]

{ #category : #'instance creation' }
BlFocusProcessor >> newFocusInEvent [
	"Create, initialize and return a focus-in event that should be sent
	as a part of focus processing"
	<return: #BlFocusInEvent>
	
	^ BlFocusInEvent new
]

{ #category : #'instance creation' }
BlFocusProcessor >> newFocusOutEvent [
	"Create, initialize and return a focus-out event that should be sent
	as a part of blur processing"
	<return: #BlFocusOutEvent>
	
	^ BlFocusOutEvent new
]

{ #category : #'instance creation' }
BlFocusProcessor >> newFocusTransferEvent [
	"Create, initialize and return a focus transfer event that should be sent to the element
	before performing a focus transfer"
	<return: #BlFocusTransferEvent>

	^ BlFocusTransferEvent new
]

{ #category : #'initialize-release' }
BlFocusProcessor >> onSpaceClosed [
	focusOwner := nil.
	focusChain := nil
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processBlur: anElement [
	self
		assert: [ self hasFocusOwner ]
		description: [ 'Blur event can only be processed when there is a focused element' ].

	"First make a given element to loose focus, then send events"
	anElement focused: false.
	focusChain leafsDo: [ :aLeafElement | self fireFocusOutEvent: aLeafElement ].
	self fireBlurEvent: anElement
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processFocus: anElement [
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not give focus to nil' ].
	self
		assert: [ anElement ~= focusOwner ]
		description: [ 'Can not give focus to the already focused element' ].

	"first make element to be focused"
	focusOwner := anElement.
	focusChain := BlFocusChain of: focusOwner.

	self space focusOwner: anElement.
	anElement focused: true.

	"then send events"
	self fireFocusInEvent: anElement.
	self fireFocusEvent: anElement
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processTransfer: anElement [
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not give focus to nil' ].
	self
		assert: [ anElement ~= focusOwner ]
		description: [ 'Can not give focus to the already focused element' ].
	self
		assert: [ self hasFocusOwner ]
		description: [ 'Can not transfer focus from non-focused element' ].

	self fireFocusTransferEvent: anElement from: focusOwner
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processWindowFocusIn: anEvent [

	self space grabFocus
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processWindowFocusOut: anEvent [

	self space ungrabFocus
]

{ #category : #'focus - requesting' }
BlFocusProcessor >> requestFor: anElement [
	self
		assert: [ anElement isNotNil ]
		description: [ 'Focus requester must not be nil!' ].

	focusOwner = anElement
		ifTrue: [ ^ self ].
		
	anElement isFocusable
		ifFalse: [ ^ self ].

	"we should only process blur event when there is focused element, otherwise skip it"
	self hasFocusOwner
		ifTrue: [ self processBlur: focusOwner ].

	"don't forget to forget focused element"
	focusOwner := nil.
	"focus is processed with new requested focus owner"
	self processFocus: anElement
]

{ #category : #'focus - requesting' }
BlFocusProcessor >> transferTo: anElement [
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not transfer focus to nil!' ].

	self hasFocusOwner
		ifFalse: [ ^ self requestFor: anElement ].

	self processTransfer: anElement.
	self processBlur: focusOwner.
	"don't forget to forget focused element"
	focusOwner := nil.
	self processFocus: anElement
]
