Extension { #name : #AlbExamplesSeeClassSide }

{ #category : #'*Bloc-Alexandrie' }
AlbExamplesSeeClassSide class >> alexandrieFixedMeasurer [
	^ BATextElementMockedMeasurer new
		ascent: self ascent;
		descent: self descent;
		glyphWidth: self glyphWidth;
		glyphHeight: self glyphHeight
]
