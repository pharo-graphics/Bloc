Extension { #name : #WorldMorph }

{ #category : #'*BlocHost-Morphic' }
WorldMorph >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"

	^ self worldState worldRenderer isTextInputActive
]

{ #category : #'*BlocHost-Morphic' }
WorldMorph >> startTextInput [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	self worldState worldRenderer startTextInput
]

{ #category : #'*BlocHost-Morphic' }
WorldMorph >> startTextInputAtRectangle: aRectangle [

	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	self worldState worldRenderer startTextInputAtRectangle: aRectangle
]

{ #category : #'*BlocHost-Morphic' }
WorldMorph >> stopTextInput [
	"Stop receiving any text input events"

	self worldState worldRenderer stopTextInput
]
