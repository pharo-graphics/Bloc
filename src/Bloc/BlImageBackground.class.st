"
I am a special image type background given as Form.

Note: I am never #isTransparent even if all Form pixels are transparent. The reason for this is the fact that ther is no fast way to detect if a Form is completly transparent without checking all pixels.

## Examples 
Examples are provided by the class `BlImageBackgroundExamples`.

"
Class {
	#name : #BlImageBackground,
	#superclass : #BlBackground,
	#instVars : [
		'image'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #'instance creation' }
BlImageBackground class >> image: aForm [

	^ self new
		image: aForm;
		yourself
]

{ #category : #comparing }
BlImageBackground >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	anotherObject class = self class ifFalse: [ ^ false ].
	anotherObject opacity = self opacity ifFalse: [ ^ false ].
	^ anotherObject image = self image
]

{ #category : #accessing }
BlImageBackground >> image [
	"Return the form that represents the visual of the background."

	^ image
]

{ #category : #accessing }
BlImageBackground >> image: aForm [

	image isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].
		
	image := aForm
]

{ #category : #testing }
BlImageBackground >> isTransparent [
	"Unfortunately there is no fast way to detect if a Form is completely transparent,
	the only check we can afford to do is to see whether the extent of the form is positive"

	^ (self opacity closeTo: 0.0) or: [ image width = 0 or: [ image height = 0 ] ]
]

{ #category : #geometry }
BlImageBackground >> matchExtent: anExtent [
	"Not sure what we should do with image background.
	Will implement later"
]
