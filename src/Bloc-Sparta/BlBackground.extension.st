Extension { #name : #BlBackground }

{ #category : #'*Bloc-Sparta' }
BlBackground >> drawOnSpartaCanvas: aCanvas of: anElement [
	"Draw a background of a given element on a provided Sparta Canvas.
	If background is transparent do nothing"

	self subclassResponsibility
]
