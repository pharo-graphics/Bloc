Extension { #name : #BlKeyCombination }

{ #category : #'*Bloc-Extensions' }
BlKeyCombination >> gtPreviewFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Combination';
		glamorousCodeFontAndSize;
		fontSize: 30;
		text: [ self printString ]
]
