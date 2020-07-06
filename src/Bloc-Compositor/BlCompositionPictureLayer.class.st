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
BlCompositionPictureLayer >> asElement [
	<return: #BlElement>
	| anElement |
	
	anElement := BlSpartaElement new
		size: self picture bounds extent;
		relocate: self picture bounds origin;
		rendering: [ :aCanvas :aSpartaElement |
			aSpartaElement userData
				at: #skiaLayer
				ifPresent: [ :aSkiaLayer | SkiaCompositor newDuring: [ :aCompositor | aCompositor draw: aSkiaLayer on: aCanvas ] ].

			self needsCache
				ifTrue: [ 
					aCanvas stroke
						path: aSpartaElement bounds inLocal asRectangle;
						paint: (Color gray alpha: 0.4);
						width: (self totalMatrix inverse transformX: 2.0 Y: 2.0) max;
						draw ]. ].

	anElement userData at: #skiaLayer put: (self asSkiaLayer needsCache: false).
	^ anElement
]

{ #category : #accessing }
BlCompositionPictureLayer >> asForm [
	^ self picture
		ifNil: [ Form extent: 0@0 depth: 32 ]
		ifNotNil: [ self picture asForm ]
]

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
