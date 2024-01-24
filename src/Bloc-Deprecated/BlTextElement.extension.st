Extension { #name : #BlTextElement }

{ #category : #'*Bloc-Deprecated' }
BlTextElement >> baseline [

	self
		deprecated: 'Please use baselineMeasurer instead.'
		transformWith:
			'`@receiver baseline'
				-> '`@receiver baselineMeasurer'.
	
	^ self baselineMeasurer
]

{ #category : #'*Bloc-Deprecated' }
BlTextElement >> rawParagraph [

	self
		deprecated: 'Please use paragraph instead.'
		transformWith:
			'`@receiver rawParagraph'
				-> '`@receiver paragraph'.
	
	^ self paragraph
]
