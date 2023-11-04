Extension { #name : 'OSWorldRenderer' }

{ #category : '*BlocHost-Morphic' }
OSWorldRenderer >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"
	^ osWindow isTextInputActive
]

{ #category : '*BlocHost-Morphic' }
OSWorldRenderer >> startTextInput [
	
	osWindow startTextInput
]

{ #category : '*BlocHost-Morphic' }
OSWorldRenderer >> startTextInputAtRectangle: aRectangle [

	"Used by a morph to request text edition capabilities.
	The rendering backend can use this information to, for example, open the IME (input-method-editor). The rectangle indicates the position where the IME menu could be shown.
	
	This version or requestTextEditing **must** be sent before any text input event can be received.
	Typically, when an editor get the focus. This version with a rectangle as argument can be sent whenever the input cursor position change to ensure the right positionnig of the IME.
	
	Use it in pair with requestStopTextEditing"

	osWindow startTextInputAtRectangle: aRectangle
]

{ #category : '*BlocHost-Morphic' }
OSWorldRenderer >> stopTextInput [
	
	osWindow stopTextInput
]
