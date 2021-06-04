"
# Backgrounds

The class {{gtClass:BlBackground}} defines the background of a Bloc element. As this is an abstract class, the actual concrete types of backgrounds are defined by its subclasses. 

There are four main types of backgrounds:
- {{gtClass:BlPaintBackground}}: color background defined using a {{gtClass:BlPaint}} object;
- {{gtClass:BlImageBackground}}: image background defined using a {{gtClass:Form}} object;
- {{gtClass:BlTransparentBackground}}: a special case of a transparent background;
- {{gtClass:BlCompositeBackground}}: a background that provided the ability to compose multiple other {{gtClass:BlBackground}} objects.

## Paint Backgrounds
The simplest of the available backgrounds is the paint background. A paint can be either a simple color or a type of gradient.


"
Class {
	#name : #BlBackgroundExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #'background - builder' }
BlBackgroundExamples >> buildBackgroundWithImagesAndColor [
	<gtExample>
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
BlBackgroundExamples >> transparentBackground [
	<gtExample>
	| aBackground |
	
	aBackground := BlTransparentBackground new.

	self assert: aBackground isTransparent.
	self assert: aBackground opacity equals: 1.0.

	^ aBackground
]
