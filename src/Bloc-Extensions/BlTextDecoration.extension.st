Extension { #name : #BlTextDecoration }

{ #category : #'*Bloc-Extensions' }
BlTextDecoration >> gtPreviewFor: aView [
	<gtView>

	self class isAbstract
		ifTrue: [ ^ aView empty ].
	
	^ aView text
		title: 'Preview';
		priority: 1;
		text: [
			'Decoration' asRopedText
				fontSize: 20;
				decorationDo: [ :aTextDecorationAttribute | aTextDecorationAttribute decoration: self ] ]
]
