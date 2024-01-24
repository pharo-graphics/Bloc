Extension { #name : #BlTextParagraph }

{ #category : #'*Bloc-Deprecated' }
BlTextParagraph >> baseline: aBlTextParagraphBaselineMeasurer [

	self
		deprecated: 'Please use baselineMeasurer: instead.'
		transformWith:
			'`@receiver baseline: `@statements1'
				-> '`@receiver baselineMeasurer: `@statements1'.

	self baselineMeasurer: aBlTextParagraphBaselineMeasurer.

]
