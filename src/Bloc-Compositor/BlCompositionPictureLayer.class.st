Class {
	#name : #BlCompositionPictureLayer,
	#superclass : #BlCompositionLayer,
	#instVars : [
		'picture',
		'needsCache',
		'isSimple'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #accessing }
BlCompositionPictureLayer >> asForm [
	^ self picture
		ifNil: [ Form extent: 0@0 depth: 32 ]
		ifNotNil: [ self picture asForm ]
]

{ #category : #converting }
BlCompositionPictureLayer >> asSkiaLayer [
	self
		assert: [ self picture isNotNil ]
		description: [ 'Can not create a layer for nil picture' ].

	^ (SkiaCompositionPictureLayer picture: self picture) needsCache: self isWorthCaching
]

{ #category : #drawing }
BlCompositionPictureLayer >> drawOnSpartaCanvas: aCanvas [
	aCanvas fill
		paint: self picture;
		path: self picture bounds;
		draw
]

{ #category : #initialization }
BlCompositionPictureLayer >> initialize [
	super initialize.
	
	needsCache := false
]

{ #category : #testing }
BlCompositionPictureLayer >> isSimple [
	<return: #Boolean>
	
	^ isSimple
]

{ #category : #testing }
BlCompositionPictureLayer >> isWorthCaching [
	<return: #Boolean>

	^ self needsCache and: [ self isSimple not ]
]

{ #category : #accessing }
BlCompositionPictureLayer >> name [
	^ self picture
		ifNil: [ 'Picture (none)' ]
		ifNotNil: [ 'Picture #', self picture uniqueId asString ]
]

{ #category : #accessing }
BlCompositionPictureLayer >> needsCache [
	^ needsCache
]

{ #category : #accessing }
BlCompositionPictureLayer >> needsCache: aBoolean [
	needsCache := aBoolean
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
		
	picture := anObject.
	isSimple := picture isSimple
]
