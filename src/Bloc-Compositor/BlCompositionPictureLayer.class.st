Class {
	#name : #BlCompositionPictureLayer,
	#superclass : #BlCompositionLayer,
	#instVars : [
		'picture'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionPictureLayer >> asSkiaLayer [
	self
		assert: [ self picture isNotNil ]
		description: [ 'Can not create a layer for nil picture' ].

	^ SkiaCompositionPictureLayer picture: self picture
]

{ #category : #drawing }
BlCompositionPictureLayer >> drawOnSpartaCanvas: aCanvas [
	aCanvas fill
		paint: self picture;
		path: self picture bounds;
		draw
]

{ #category : #'gt-extension' }
BlCompositionPictureLayer >> gtPictureFor: aView [
	<gtView>
	^ aView explicit
		title: 'Picture';
		priority: 5;
		stencil: [ self picture
			ifNil: [ BlElement new ]
			ifNotNil: [ self picture asForm asElement ] ]
]

{ #category : #accessing }
BlCompositionPictureLayer >> name [
	^ 'Picture #', self picture uniqueId asString
]

{ #category : #accessing }
BlCompositionPictureLayer >> picture [
	^ picture
]

{ #category : #accessing }
BlCompositionPictureLayer >> picture: anObject [
	self
		assert: [ anObject isNotNil ]
		description: [ 'Picture must not be nil' ].
		
	picture := anObject
]
