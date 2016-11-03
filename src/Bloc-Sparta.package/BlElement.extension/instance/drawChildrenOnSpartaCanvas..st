*Bloc-Sparta
drawChildrenOnSpartaCanvas: aCanvas
	
	self clipChildren ifTrue: [ 
		aCanvas clip push: (pathCache borderPathOnSpartaCanvas: aCanvas) ].

	[ self children zReversed do: [ :c | c fullDrawOnSpartaCanvas: aCanvas ] ]
		ensure: [ self clipChildren ifTrue: [ aCanvas clip pop ] ]