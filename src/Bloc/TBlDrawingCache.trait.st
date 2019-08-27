"
I add support of drawing cache to any element.

Simple use me in a class definition and implement explicitly required methods from private accessing protocol
"
Trait {
	#name : #TBlDrawingCache,
	#instVars : [
		'blCachedSurface',
		'blSession',
		'blDamageReported'
	],
	#category : #'Bloc-Utilities - Drawing Cache'
}

{ #category : #'api - drawing cache' }
TBlDrawingCache classSide >> disableDrawingCacheFor: anElement [
	anElement userData
		at: #blDrawingCacheEnabled
		put: false
]

{ #category : #'api - drawing cache' }
TBlDrawingCache classSide >> enableDrawingCacheFor: anElement [
	anElement userData
		at: #blDrawingCacheEnabled
		put: true
]

{ #category : #'api - drawing cache' }
TBlDrawingCache classSide >> isDrawingCacheEnabledFor: anElement [
	^ anElement userData
		at: #blDrawingCacheEnabled
		ifAbsent: [ true ]
]

{ #category : #'private - accessing' }
TBlDrawingCache >> cachedSurface [
	^ blCachedSurface
]

{ #category : #'private - accessing' }
TBlDrawingCache >> cachedSurface: aSurface [
	blCachedSurface := aSurface
]

{ #category : #'private - accessing' }
TBlDrawingCache >> damageReported [
	^ blDamageReported
]

{ #category : #'private - accessing' }
TBlDrawingCache >> damageReported: aBoolean [
	blDamageReported := aBoolean
]

{ #category : #'change reporting' }
TBlDrawingCache >> invalidRect: aBlBounds from: anElement [
	"we should only optimize it for children. I myself should invalidate as usually.
	The problem is that if we optimize for myself, then the second invalidation after
	position / extent change will be ignored which leads to redraw problems"
	
	anElement == self
		ifTrue: [ ^ super invalidRect: aBlBounds from: anElement ].
	
	"we compare with true because it is nil by default (I am coming from a Trait)"
	self damageReported == true
		ifTrue: [ ^ self ].

	super invalidRect: (self invalidationBounds: self class invalidationBounds) from: anElement.

	self damageReported: true.
	
	self releaseCaches
]

{ #category : #'hooks - geometry' }
TBlDrawingCache >> onAddedToSuperParent: aParentElement [
	super onAddedToSuperParent: aParentElement.

	self releaseCaches
]

{ #category : #'children hooks' }
TBlDrawingCache >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.

	self releaseCaches
]

{ #category : #'hooks - geometry' }
TBlDrawingCache >> onTransformationInSpaceChanged [
	super onTransformationInSpaceChanged.
	
	self releaseCaches
]

{ #category : #initialization }
TBlDrawingCache >> releaseCaches [
	self cachedSurface ifNotNil: #release.
	self cachedSurface: nil.

	self damageReported: false.

	"we may be embedded in the other elements with drawing cache.
	When my cache changes we should invalidate our parents too"
	self invalidate
]

{ #category : #'private - accessing' }
TBlDrawingCache >> session [
	^ blSession
]

{ #category : #'private - accessing' }
TBlDrawingCache >> session: aSession [
	blSession := aSession
]
