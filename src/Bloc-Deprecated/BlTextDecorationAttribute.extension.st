Extension { #name : #BlTextDecorationAttribute }

{ #category : #'*Bloc-Deprecated' }
BlTextDecorationAttribute >> paint: aColor [
	self
		deprecated: 'Use color: instead'
		transformWith: '`@receiver paint: `@statements1'
				-> '`@receiver color: `@statements1'.
				
	self color: aColor
]

{ #category : #'*Bloc-Deprecated' }
BlTextDecorationAttribute >> width: aNumber [
	self
		deprecated: 'Use thickness: instead'
		transformWith: '`@receiver width: `@statements1'
				-> '`@receiver thickness: `@statements1'.

	self thickness: aNumber
]
