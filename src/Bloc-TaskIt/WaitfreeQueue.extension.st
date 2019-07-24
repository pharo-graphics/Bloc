Extension { #name : #WaitfreeQueue }

{ #category : #'*Bloc-TaskIt' }
WaitfreeQueue >> itemArray [
	"Answer an array of the receiver's items, excluding the dummy"

	| item |

	item := dummy.
	^Array streamContents: [ :stream |
		[ item := item next.
		stream nextPut: item.
		item isCircular ] whileFalse ].
]
