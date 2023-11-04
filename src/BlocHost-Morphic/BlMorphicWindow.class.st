"
I am a special case of StandardWindow that is used as host window for bloc space.

I provide helper methods to be used by event handler and moprhic host space
"
Class {
	#name : 'BlMorphicWindow',
	#superclass : 'StandardWindow',
	#instVars : [
		'hostSpace',
		'preventResize',
		'spaceHostMorph'
	],
	#category : 'BlocHost-Morphic-Host - Window',
	#package : 'BlocHost-Morphic',
	#tag : 'Host - Window'
}

{ #category : 'accessing' }
BlMorphicWindow >> borderless: aBoolean [
	"Make window borderless if true is given"
	
	aBoolean ifTrue: [ 
		self
			makeBorderless;
			beWithoutGrips;
			removeLabelArea ]
		ifFalse: [
			self makeBordered.
			self beWithGrips
		]
]

{ #category : 'accessing' }
BlMorphicWindow >> center [
	"Center this window in #currentWorld. There is no effect before the window is open."

	self position: self currentWorld extent - self extent // 2
]

{ #category : 'accessing' }
BlMorphicWindow >> form: aForm [
	spaceHostMorph form: aForm
]

{ #category : 'accessing' }
BlMorphicWindow >> fullsize: aBoolean [
	"Make window borderless if true is given"
	
	aBoolean
		ifTrue: [
			label delete.
			spaceHostMorph layoutFrame topOffset: spaceHostMorph layoutFrame topOffset - labelArea height ]
		ifFalse: [ 
			
		]
]

{ #category : 'accessing' }
BlMorphicWindow >> hostSpace [
	^ hostSpace
]

{ #category : 'accessing' }
BlMorphicWindow >> hostSpace: aHostSpace [
	
	hostSpace := aHostSpace.
	spaceHostMorph hostSpace: aHostSpace
]

{ #category : 'initialization' }
BlMorphicWindow >> initialize [
	super initialize.

	spaceHostMorph := BlMorphicSpaceHostMorph new.
	self addMorph: spaceHostMorph fullFrame: (0@0 extent: 1@1).
	preventResize := false
]

{ #category : 'geometry' }
BlMorphicWindow >> resizeDuring: aBlock [
	
	preventResize
		ifTrue: [ ^ self ].
	
	preventResize := true.
	aBlock ensure: [ preventResize := false ]
]

{ #category : 'geometry' }
BlMorphicWindow >> spaceExtent [
	| aDelta |
	
	"we compute decorations extent first"
	aDelta := self fullBounds extent - spaceHostMorph extent.
	^ self extent - aDelta
]

{ #category : 'geometry' }
BlMorphicWindow >> spaceExtent: anExtent [

	self resizeDuring: [
		self spaceExtent = anExtent
			ifFalse: [
				| aDelta |
				"We compute decorations extent first"
				aDelta := self fullBounds extent - spaceHostMorph extent.
				self extent: anExtent + aDelta ] ]
]

{ #category : 'accessing' }
BlMorphicWindow >> spaceHostMorph [
	^ spaceHostMorph
]
