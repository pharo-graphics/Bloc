drawing
drawChildrenOn: aCanvas
	aCanvas
		clipByPath: (self clipChildren ifTrue:[(pathCache borderPathOn: aCanvas)] ifFalse:[nil])
		during: [	 self children zReversed do: [ :c | c fullDrawOnAthensCanvas: aCanvas ] ]