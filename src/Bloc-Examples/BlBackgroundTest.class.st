Class {
	#name : #BlBackgroundTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-DocumentationExamples'
}

{ #category : #'background - builder' }
BlBackgroundTest >> testBuildBackgroundWithImagesAndColor [

	| aBackground aBuilder |	
	aBuilder := BlBackground builder.
	aBuilder image
		form: PolymorphSystemSettings pharoLogoForm;
		opacity: 0.6.
	aBuilder image
		form: (Smalltalk ui icons iconNamed: #info).
	aBuilder paint
		paint: Color gray;
		opacity: 0.2.

	aBackground := aBuilder build.

	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground backgrounds size equals: 3.

	self assert: aBackground backgrounds first opacity equals: 0.6.
	self assert: aBackground backgrounds first image bits equals: PolymorphSystemSettings pharoLogoForm bits.

	self assert: aBackground backgrounds second opacity equals: 1.0.
	self assert: aBackground backgrounds second image bits equals: (Smalltalk ui icons iconNamed: #info) bits.

	self assert: aBackground backgrounds third opacity equals: 0.2.
	self assert: aBackground backgrounds third paint color equals: Color gray.

	^ aBackground
]

{ #category : #'background - transparent' }
BlBackgroundTest >> testTransparentBackground [

	| aBackground |
	aBackground := BlTransparentBackground new.
	self assert: aBackground isTransparent.
	self assert: aBackground opacity equals: 1.0.

	^ aBackground
]
