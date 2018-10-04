"
I am a special image type background given as Form.

Note: I am never #isTransparent even if all Form pixels are transparent. The reason for this is the fact that ther is no fast way to detect if a Form is completly transparent without checking all pixels.

Example:

	BlImageBackground image: ((Form extent: 50@50 depth: 32) fillColor: Color blue)
	
	or
	
	BlImageBackground new
		image: PolymorphSystemSettings pharoLogoForm;
		yourself
		
Opacity example:

	BlImageBackground new
		opacity: 0.5;
		image: PolymorphSystemSettings pharoLogoForm;
		yourself
"
Class {
	#name : #BlImageBackground,
	#superclass : #BlBackground,
	#instVars : [
		'image',
		'session',
		'bitmap'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #'instance creation' }
BlImageBackground class >> image: aForm [
	^ self new image: aForm
]

{ #category : #accessing }
BlImageBackground >> image [
	<return: #Form>

	^ image
]

{ #category : #accessing }
BlImageBackground >> image: aForm [
	self
		assert: [ aForm isNotNil ]
		description: [ 'Image must not be nil' ].

	image isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].
		
	image := aForm.
	bitmap := nil
]

{ #category : #testing }
BlImageBackground >> isTransparent [
	"Unfortunately there is no fast way to detect if a Form is completely transparent"
	<return: #Boolean>

	^ false
]

{ #category : #geometry }
BlImageBackground >> matchExtent: anExtent [
	"Not sure what we should do with image background.
	Will implement later"
]
