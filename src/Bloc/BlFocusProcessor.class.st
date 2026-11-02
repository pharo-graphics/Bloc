"
I'm responsible of processing events and requests related to focus gain and loose.
"
Class {
	#name : #BlFocusProcessor,
	#superclass : #BlBaseEventProcessor,
	#instVars : [
		'focusChain'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #accessing }
BlFocusProcessor >> focusOwner [

	self
		deprecated: 'Use space focusOwner instead'
		transformWith: '`@receiver focusOwner' -> '`@receiver space focusOwner'.

	^ space focusOwner
]

{ #category : #accessing }
BlFocusProcessor >> focusOwner: anElement [

	self
		deprecated: 'Use space focusOwner: instead'
		transformWith: '`@receiver focusOwner: `@arg' -> '`@receiver space focusOwner: `@arg'.

	space focusOwner: anElement
]

{ #category : #'focus - processing' }
BlFocusProcessor >> handleMouseDown: anEvent [
	"Clicking outside does not mean focus should be lost"
]

{ #category : #testing }
BlFocusProcessor >> hasFocusOwner [
	"Return true if there is an element owning focus in my space, false otherwise.
	When there are no elements interested in focus it is given to the root element.
	Note: focus owner may not exist during space initialization or inbetween blur and focus events"

	^ space focusOwner notNil
]

{ #category : #'focus - requesting' }
BlFocusProcessor >> loseFor: anElement [

	| focusDelegate |
	focusDelegate := anElement focusDelegate.
	space focusOwner ~= focusDelegate ifTrue: [ ^ self ].

	self processBlur: focusDelegate.
	"don't forget to forget focused element"
	space focusOwner: nil
]

{ #category : #'initialize-release' }
BlFocusProcessor >> onSpaceClosed [

	space focusOwner: nil.
	focusChain := nil
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processBlur: anElement [
	"Process and fire the corresponding blur events that occurs when an element looses focus."

	"First, mark the received element as unfocused, then send events"
	space focusOwner: nil.
	anElement focused: false.
	
	"Fire events. Blur doesn't bubble; FocusOut does bubble."
	self
		dispatchEvent:
			(BlBlurEvent new
				target: anElement;
				dueToRemoval: false;
				yourself)
		target: anElement.

	focusChain leafsDo: [ :aLeafElement |
		self fireEvent:
			(BlFocusOutEvent new
				target: aLeafElement;
				dueToRemoval: false;
				yourself) ]
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processBlur: anElement dueToFocus: aNewFocusedElement dueToRemoval: aBoolean [
	"Process and fire the corresponding blur events that occurs when an element looses focus."

	"First, mark the received element as unfocused, then send events"
	space focusOwner: nil.
	anElement focused: false.

	"Fire Blur; it doesn't bubble"
	self
		dispatchEvent: (BlBlurEvent new
				 target: anElement;
				 dueToRemoval: aBoolean;
				 yourself)
		target: anElement.

	"Fire FocusOut; they bubble"
	focusChain leafsDo: [ :aLeafElement | "if a new focused element is a child we
		don't have to send focus-out event"
		(aNewFocusedElement allParentsInclude: aLeafElement) ifFalse: [
			| anEvent |
			anEvent := BlFocusOutEvent new
				           target: aLeafElement;
				           dueToRemoval: aBoolean;
				           yourself.

			aLeafElement
				firstCommonParent: aNewFocusedElement
				ifFound: [ :aParent | self fireEvent: anEvent from: aParent ]
				ifNone: [ self fireEvent: anEvent ] ] ]
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processFocus: anElement [
	"Process and fire the corresponding focus and focus-in events that
	occurs when an element gains focus."

	"First, mark the element as focused"
	space focusOwner: anElement.
	focusChain := BlFocusChain of: space focusOwner.
	anElement focused: true.

	"Fire events. Focus doesn't bubble; FocusIn does bubble."
	self
		dispatchEvent:
			(BlFocusEvent new
				target: anElement;
				yourself)
		target: anElement.
	self fireEvent:
		(BlFocusInEvent new
			target: anElement;
			yourself)
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processFocus: anElement dueToTransferFrom: aPreviousFocus [
	"Process and fire the corresponding focus and focus-in events that
	occurs when an element gains focus."

	"First, mark the element as focused"

	space focusOwner: anElement.
	focusChain := BlFocusChain of: space focusOwner.
	anElement focused: true.

	"Fire Focus; it doesn't bubble"
	self
		dispatchEvent: (BlFocusEvent new
				 target: anElement;
				 yourself)
		target: anElement.

	"Fire FocusIn; they bubble"
	focusChain leafsDo: [ :aLeafElement |
		| anEvent |
		anEvent := BlFocusInEvent new
			           target: aLeafElement;
			           yourself.

		"if a new focused element is a child we don't have to send focus-in event"
		(aLeafElement allParentsInclude: aPreviousFocus)
			ifFalse: [
				aLeafElement
					firstCommonParent: aPreviousFocus
					ifFound: [ :aCommonParent |
						aLeafElement == aCommonParent ifFalse: [
							self fireEvent: anEvent from: aCommonParent ] ]
					ifNone: [ self fireEvent: anEvent ] ]
			ifTrue: [
				aLeafElement == aPreviousFocus ifFalse: [
					self fireEvent: anEvent from: aPreviousFocus ] ] ]
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processWindowFocusIn: anEvent [

	space grabFocus
]

{ #category : #'focus - processing' }
BlFocusProcessor >> processWindowFocusOut: anEvent [

	space ungrabFocus
]

{ #category : #'focus - requesting' }
BlFocusProcessor >> requestFor: anElement dueToRemoval: aBoolean [

	| aPreviousFocusOwner focusDelegate |
	focusDelegate := anElement focusDelegate.
	space focusOwner = focusDelegate ifTrue: [ ^ self ].
	focusDelegate isFocusable ifFalse: [ ^ self ].

	"keep reference to the previous focus owner"
	aPreviousFocusOwner := space focusOwner.

	"we should only process blur event when there is a
	focused element; otherwise, skip it."
	self hasFocusOwner ifTrue: [
		self
			processBlur: aPreviousFocusOwner
			dueToFocus: anElement
			dueToRemoval: aBoolean ].
	space focusOwner: nil.

	"focus is processed with new requested focus owner"
	aPreviousFocusOwner
		ifNil: [ self processFocus: focusDelegate ]
		ifNotNil: [
			self
				processFocus: focusDelegate
				dueToTransferFrom: aPreviousFocusOwner ]
]
