Extension { #name : #Morph }

{ #category : #'*BlocHost-Morphic' }
Morph >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"
	self owner ifNil: [ ^ false ].
	^ self owner isTextInputActive
]

{ #category : #'*BlocHost-Morphic' }
Morph >> stopTextInput [
	"Stop receiving any text input events"

	self owner stopTextInput
]
