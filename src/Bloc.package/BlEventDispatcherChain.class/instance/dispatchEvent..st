api - event managing
dispatchEvent: anEvent
	"Dispatch a given event through the whole dispatcher chain"
	| aPreviousChain |

	aPreviousChain := self hasPrevious
		ifTrue: [ self previous ]
		ifFalse: [ self class empty ].

	^ self dispatcher dispatchEvent: anEvent next: aPreviousChain