api - event managing
dispatchEvent: anEvent
	"Dispatch a given event through the whole dispatcher chain"
	| aNextChain |

	aNextChain := self hasNext
		ifTrue: [ self next ]
		ifFalse: [ self class empty ].

	^ self dispatcher dispatchEvent: anEvent next: aNextChain