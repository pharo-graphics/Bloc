rope - accessing
at: anIndex
	| leftSize |
	
	leftSize := left size.

	^ anIndex <= leftSize
		ifTrue: [ left at: anIndex ]
		ifFalse: [ right at: anIndex - leftSize ]