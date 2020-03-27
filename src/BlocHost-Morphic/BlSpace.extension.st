Extension { #name : #BlSpace }

{ #category : #'*BlocHost-Morphic' }
BlSpace >> showNotification: anElement [
	"hack - for now just add the element"

	root addChild: anElement
]
