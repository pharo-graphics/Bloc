"
# Background

I represent a background of the `BlElement`. 
**I am immutable and can not be changed once created.** To modify the background, create a new instance and set it by sending `BlElement>>#background:`

## Types of background

There are multiple pre-built types of background:
 - paint background `BlPaintBackground` which allows users to use any `BlPaint` as a background
 - image background `BlImageBackground` to use a bitmap `Form`
 - composite background `BlCompositeBackground` letting users to compose different types of background into one more complex background
 - transparent background `BlTransparentBackground` as a special type of background that 

Background can be instantiated and composed directly or with the help of `BlBackgroundBuilder`.
See `BlBackgroundBuilder` for the related examples.

"
Class {
	#name : #BlBackground,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'opacity'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #builder }
BlBackground class >> builder [

	^ BlCompositeBackgroundBuilder new
]

{ #category : #'instance creation' }
BlBackground class >> formSet: aFormSet [
	
	^ BlFormSetBackground formSet: aFormSet
]

{ #category : #'instance creation' }
BlBackground class >> image: aForm [
	
	^ BlImageBackground image: aForm
]

{ #category : #'instance creation' }
BlBackground class >> paint: aColorOrBlPaint [

	^ BlPaintBackground paint: aColorOrBlPaint
]

{ #category : #'instance creation' }
BlBackground class >> transparent [
	"Return a completely transparent background"
	
	^ BlTransparentBackground uniqueInstance
]

{ #category : #converting }
BlBackground >> asBlBackground [

	^ self
]

{ #category : #initialization }
BlBackground >> defaultOpacity [
	"By default background is completely opaque so it returns a float indicating it: 1.0"

	^ 1.0
]

{ #category : #testing }
BlBackground >> isColorBackground [

	^ self isPaintBackground and: [ self paint isColorPaint ]
]

{ #category : #testing }
BlBackground >> isOpaque [
	"Return true if the whole background is opaque"
	
	^ false
]

{ #category : #testing }
BlBackground >> isPaintBackground [

	^ false
]

{ #category : #testing }
BlBackground >> isTransparent [
	"Return true if background is transparent and should not be rendered, false otherwise"

	^ self subclassResponsibility
]

{ #category : #geometry }
BlBackground >> matchExtent: anExtent [
	"Resize background to match given extent.
	Used to adapt image or gradient backgrounds to the element's extent"

	self subclassResponsibility
]

{ #category : #accessing }
BlBackground >> opacity [
	"Return a float representing the opacity of the receiver. 1.0 meaning that it is opaque and 0 that it is fully transparent."

	^ opacity ifNil: [ self defaultOpacity ]
]

{ #category : #accessing }
BlBackground >> opacity: aNumber [
	"Opacity value must be within interval [0..1]. 1.0 meaning that the receiver is opaque."

	opacity isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].
	self opacity = aNumber
		ifTrue: [ ^ self ].
	opacity := aNumber
]

{ #category : #accessing }
BlBackground >> paint [

	^ nil
]
