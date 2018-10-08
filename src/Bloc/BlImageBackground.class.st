"
I am a special image type background given as Form.

Note: I am never #isTransparent even if all Form pixels are transparent. The reason for this is the fact that ther is no fast way to detect if a Form is completly transparent without checking all pixels.

To create instances of me users can use the class side factory method ==image:== with a form as parameter. 
[[[  
BlImageBackground 
	image: ((Form extent: 50@50 depth: 32) fillColor: Color blue)
]]]
	
[[[ 
BlImageBackground new
	image: PolymorphSystemSettings pharoLogoForm
]]]
		
Alternatively, the message ==#asBlBackground== can directly be send to the ==Form== object to obtain a background:
[[[
PolymorphSystemSettings pharoLogoForm asBlBackground.
]]]
		
Opacity example:

[[[ 
BlImageBackground new
	opacity: 0.5;
	image: PolymorphSystemSettings pharoLogoForm
]]]
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
	"Unfortunately there is no fast way to detect if a Form is completely transparent,
	the only check we can afford to do is to see whether the extent of the form is positive"
	<return: #Boolean>

	^ (self opacity closeTo: 0) or: [ self image extent min = 0 ]
]

{ #category : #geometry }
BlImageBackground >> matchExtent: anExtent [
	"Not sure what we should do with image background.
	Will implement later"
]
