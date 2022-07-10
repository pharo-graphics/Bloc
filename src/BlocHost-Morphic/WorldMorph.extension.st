Extension { #name : #WorldMorph }

{ #category : #'*BlocHost-Morphic' }
WorldMorph >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"
	^ self worldState worldRenderer isTextInputActive
]

{ #category : #'*BlocHost-Morphic' }
WorldMorph >> requestTextEditing [

	self worldState worldRenderer requestTextEditing 
]
