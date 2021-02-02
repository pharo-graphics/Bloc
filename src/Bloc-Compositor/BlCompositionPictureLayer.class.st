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

{ #category : #converting }
BlCompositionPictureLayer >> asSkiaLayer [
	^ self picture
		ifNil: [ SkiaCompositionPictureLayer new ]
		ifNotNil: [ :aPicture | (SkiaCompositionPictureLayer picture: aPicture) needsCache: self isWorthCaching ]
]

{ #category : #converting }
BlCompositionPictureLayer >> asSymbolTree [
	^ {
		#Picture .
			#cache . self needsCache.
			#simple . self isSimple
	}
]

{ #category : #accessing }
BlCompositionPictureLayer >> depth [
	| aDepth |
	
	aDepth := 0.
	self parentsDo: [ :eachLayer | (eachLayer isKindOf: BlCompositionOffsetLayer)
		ifTrue: [ aDepth := aDepth + 1 ] ].
	
	self
		parentSuchThat: [ :eachLayer | eachLayer isKindOf: BlCompositionOffsetLayer ]
		do: [ :anOffsetLayer | aDepth + (anOffsetLayer allPictureLayers indexOf: self) ].	

	^ aDepth
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
	
	needsCache := false.
	isSimple := false
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

{ #category : #'private - context' }
BlCompositionPictureLayer >> pictureLayersDo: aBlock [
	aBlock value: self
]

{ #category : #'private - context' }
BlCompositionPictureLayer >> totalMatrix [
	| aMatrix |
	
	aMatrix := BlMatrix2D new.
	self reversedParentsDo: [ :eachLayer | eachLayer multiplyOn: aMatrix ].
	^ aMatrix
]
