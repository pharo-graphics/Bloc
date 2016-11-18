children add/remove
removeChild: aChildElement
	"Remove aChildElement from infinite element
	and do not track it anymore (unhide and remove from bucket)"
	| index |

	index := controller childIndexOf: aChildElement.
	index <= 0
		ifTrue: [ ^ self ].
	
	(bucket remove: index)
		ifTrue: [ self unhideChildInternal: aChildElement ].

	controller removeChildAt: index