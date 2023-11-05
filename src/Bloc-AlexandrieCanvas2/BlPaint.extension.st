Extension { #name : 'BlPaint' }

{ #category : '*Bloc-AlexandrieCanvas2' }
BlPaint >> asBABackgroundAlpha: backgroundOpacity [
	"Answer myself as a figure background, with certain opacity
	i.e. a value in the range [0..1]."

	^ self subclassResponsibility


]
