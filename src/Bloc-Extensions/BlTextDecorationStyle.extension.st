Extension { #name : #BlTextDecorationStyle }

{ #category : #'*Bloc-Extensions' }
BlTextDecorationStyle class >> gtPreviewFor: aView [
	<gtView>
	
	self = BlTextDecorationStyle
		ifTrue: [ ^ aView empty ].
	
	^ aView forward
		title: 'Style preview';
		priority: 1;
		object: [ self new ];
		view: #gtPreviewFor:
]

{ #category : #'*Bloc-Extensions' }
BlTextDecorationStyle >> gtPreviewFor: aView [
	<gtView>

	self class isAbstract
		ifTrue: [ ^ aView empty ].
	
	^ aView text
		title: 'Preview';
		priority: 1;
		text: [
			self class label asRopedText
				fontSize: 20;
				decorationDo: [ :aTextDecorationAttribute | aTextDecorationAttribute underline decoration style: self ] ]
]
