Extension { #name : #BlFocusProcessor }

{ #category : #'*Bloc-Deprecated' }
BlFocusProcessor >> looseFor: anElement [
	self
		deprecated: 'Please use loseFor: instead.'
		transformWith:
			'`@receiver looseFor: `@statements1'
				-> '`@receiver loseFor: `@statements1'.

	self loseFor: anElement
]
