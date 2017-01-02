*Bloc-Sparta
drawChildrenOnSpartaCanvas: aCanvas
	
	"If there are not children no need to draw and clip"
	self hasChildren
		ifFalse: [ ^ self ].
	
	self clipChildren ifTrue: [ 
		aCanvas clip push: (pathCache borderPathOnSpartaCanvas: aCanvas) ].

	[ self children zReversed do: [ :c | c fullDrawOnSpartaCanvas: aCanvas ] ]
		ensure: [ self clipChildren ifTrue: [ aCanvas clip pop ] ]