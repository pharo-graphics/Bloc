*Bloc-Athens-drawing
drawChildrenOnAthensCanvas: aCanvas
	aCanvas
		clipByPath: (self clipChildren ifTrue:[(pathCache borderPathOnAthensCanvas: aCanvas)] ifFalse:[nil])
		during: [	 self children zReversed do: [ :c | c fullDrawOnAthensCanvas: aCanvas ] ]