Extension { #name : #BlTextDecorationCompositeType }

{ #category : #'*Bloc-Extensions' }
BlTextDecorationCompositeType >> gtPreviewFor: aView [
	<gtView>

	self class isAbstract
		ifTrue: [ ^ aView empty ].
	
	^ aView text
		title: 'Preview';
		priority: 1;
		text: [
			| aText |
			aText := self hasTypes
				ifTrue: [ String streamContents: [ :aStream |
					types
						do: [ :eachType | aStream nextPutAll: eachType class label ]
						separatedBy: [ aStream nextPutAll: ' | ' ] ] ]
				ifFalse: [ 'No decoration' ].
			aText asRopedText
				fontSize: 20;
				decorationDo: [ :aTextDecorationAttribute | aTextDecorationAttribute decoration type: self ] ]
]
