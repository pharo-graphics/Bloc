Extension { #name : #OSWorldRenderer }

{ #category : #'*BlocHost-Morphic' }
OSWorldRenderer >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"
	^ osWindow isTextInputActive
]

{ #category : #'*BlocHost-Morphic' }
OSWorldRenderer >> requestTextEditing [
	
	osWindow startTextInput
]

{ #category : #'*BlocHost-Morphic' }
OSWorldRenderer >> startTextInput [
	
	osWindow startTextInput
]

{ #category : #'*BlocHost-Morphic' }
OSWorldRenderer >> startTextInputAtRectangle: aRectangle [
	
	osWindow startTextInputAtRectangle: aRectangle
]

{ #category : #'*BlocHost-Morphic' }
OSWorldRenderer >> stopTextInput [
	
	osWindow stopTextInput
]
