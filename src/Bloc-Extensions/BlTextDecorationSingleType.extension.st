Extension { #name : #BlTextDecorationSingleType }

{ #category : #'*Bloc-Extensions' }
BlTextDecorationSingleType >> gtPreviewFor: aView [
	<gtView>

	self class isAbstract
		ifTrue: [ ^ aView empty ].
	
	^ aView text
		title: 'Preview';
		priority: 1;
		text: [
			self class label asRopedText
				fontSize: 20;
				decorationDo: [ :aTextDecorationAttribute | aTextDecorationAttribute decoration type: self ] ]
]
