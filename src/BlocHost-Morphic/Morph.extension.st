Extension { #name : #Morph }

{ #category : #'*BlocHost-Morphic' }
Morph >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"
	self owner ifNil: [ ^ false ].
	^ self owner isTextInputActive
]

{ #category : #'*BlocHost-Morphic' }
Morph >> startTextInput [

	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	self owner ifNil: [ ^ self ].
	self owner startTextInput
]

{ #category : #'*BlocHost-Morphic' }
Morph >> startTextInputAtRectangle: aRectangle [

	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	self owner ifNil: [ ^ self ].
	self owner startTextInputAtRectangle: aRectangle
]

{ #category : #'*BlocHost-Morphic' }
Morph >> stopTextInput [
	"Stop receiving any text input events"

	self owner stopTextInput
]
