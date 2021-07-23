"
I am a special image type background given as Form.

Note: I am never #isTransparent even if all Form pixels are transparent. The reason for this is the fact that ther is no fast way to detect if a Form is completly transparent without checking all pixels.

## Examples 
Examples are provided by the class {{gtClass:BlImageBackgroundExamples}}.

"
Class {
	#name : 'BlImageBackground',
	#superclass : 'BlBackground',
	#instVars : [
		'image'
	],
	#category : 'Bloc-Basic-Background'
}

{ #category : 'instance creation' }
BlImageBackground class >> image: aForm [
	^ self new image: aForm
]

{ #category : 'accessing' }
BlImageBackground >> image [
	<return: #Form>

	^ image
]

{ #category : 'accessing' }
BlImageBackground >> image: aForm [
	self
		assert: [ aForm isNotNil ]
		description: [ 'Image must not be nil' ].

	image isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].
		
	image := aForm
]

{ #category : 'testing' }
BlImageBackground >> isTransparent [
	"Unfortunately there is no fast way to detect if a Form is completely transparent,
	the only check we can afford to do is to see whether the extent of the form is positive"
	<return: #Boolean>

	^ (self opacity closeTo: 0) or: [ self image extent min = 0 ]
]

{ #category : 'geometry' }
BlImageBackground >> matchExtent: anExtent [
	"Not sure what we should do with image background.
	Will implement later"
]
