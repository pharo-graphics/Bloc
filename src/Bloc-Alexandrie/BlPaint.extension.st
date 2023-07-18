Extension { #name : #BlPaint }

{ #category : #'*Bloc-Alexandrie' }
BlPaint >> aeApplyTo: aeCanvas [
	"Apply to a canvas either as a border or as a background."

	self subclassResponsibility
]

{ #category : #'*Bloc-Alexandrie' }
BlPaint >> aeApplyTo: aeCanvas opacity: backgroundOpacity [
	"Apply myself as a background to a canvas, with certain opacity
	i.e. a value in the range [0..1]."

	self subclassResponsibility
]
