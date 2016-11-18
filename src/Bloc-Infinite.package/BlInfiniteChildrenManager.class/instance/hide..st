hidden
hide: aChildElement
	"Marks a child element as hidden."
	| offset |

	offset := controller childIndexOf: aChildElement.
	offset <= 0
		ifTrue: [ Error signal: 'An element is not a direct child!' ].
	
	(bucket get: offset)
		ifTrue: [ Error signal: 'Trying to hide child twice' ].
		
	bucket set: offset.
	self hideChildInternal: aChildElement