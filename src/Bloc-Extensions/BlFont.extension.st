Extension { #name : 'BlFont' }

{ #category : '*Bloc-Extensions' }
BlFont >> gtInfoFor: aView [
	<gtView>

	^ ({
		#'Family name' -> self familyName.
		#Size -> self fontSize.
		#Slant -> (('{1} ({2})') format: { self fontSlant name . self fontSlant value }).
		#Stretch -> (('{1} ({2})') format: { self fontStretch name . self fontStretch value }).
		#Weight -> (('{1} ({2})') format: { self fontWeight name . self fontWeight value }).
	 } asOrderedDictionary gtItemsFor: aView)
			title: 'Info';
			priority: 7
]

{ #category : '*Bloc-Extensions' }
BlFont >> gtPreviewFor: aView [
	<gtView>
	
	^ aView text
		title: 'Preview';
		priority: 5;
		text: [
			| aText |
			aText := 'ABCDEFGHIJKLM
NOPQRSTUVWXYZ
abcdefghijklm
nopqrstuvwxyz
1234567890' asRopedText.
			self applyOnText: aText.
			aText ]
]
