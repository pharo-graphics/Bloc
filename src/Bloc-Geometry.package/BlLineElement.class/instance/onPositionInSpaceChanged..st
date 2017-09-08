geometry hooks
onPositionInSpaceChanged: aSourceElement
	super onPositionInSpaceChanged: aSourceElement.
	
	"self ~~ aSourceElement
		ifTrue: [ self updateBounds ]"