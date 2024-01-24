Extension { #name : #TBlTextStyleable }

{ #category : #'*Bloc-Deprecated' }
TBlTextStyleable >> underlinePaint: aColor width: aNumber [
	self
		deprecated: 'Use underlineColor:thickness: instead'
		transformWith: '`@receiver underlinePaint: `@statements1 width: `@statements2'
				-> '`@receiver underlineColor: `@statements1 thickness: `@statements2'.
				
	self underlineColor: aColor thickness: aNumber
]
