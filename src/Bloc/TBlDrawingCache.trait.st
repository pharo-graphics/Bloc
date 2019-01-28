"
I add support of drawing cache to any element.

Simple use me in a class definition and implement explicitly required methods from private accessing protocol
"
Trait {
	#name : #TBlDrawingCache,
	#category : #'Bloc-Utilities - Drawing Cache'
}

{ #category : #'private - accessing' }
TBlDrawingCache >> cachedSurface [
	^ self explicitRequirement
]

{ #category : #'private - accessing' }
TBlDrawingCache >> cachedSurface: aSurface [
	self explicitRequirement
]

{ #category : #'private - accessing' }
TBlDrawingCache >> damageReported [
	^ self explicitRequirement
]

{ #category : #'private - accessing' }
TBlDrawingCache >> damageReported: aBoolean [
	self explicitRequirement
]

{ #category : #'change reporting' }
TBlDrawingCache >> invalidRect: aBlBounds from: anElement [
	"we should only optimize it for children. I myself should invalidate as usually.
	The problem is that if we optimize for myself, then the second invalidation after
	position / extent change will be ignored which leads to redraw problems"
	anElement ~~ self
		ifTrue: [ ^ super invalidRect: aBlBounds from: anElement ].
	
	"we compare with true because it is nil by default (I am coming from a Trait)"
	self damageReported == true
		ifTrue: [ ^ self ].

	super invalidRect: (self invalidationBounds: self class invalidationBounds) from: anElement.

	self damageReported: true.
	
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
	self cachedSurface: nil
]

{ #category : #'private - accessing' }
TBlDrawingCache >> session [
	^ self explicitRequirement
]

{ #category : #'private - accessing' }
TBlDrawingCache >> session: aSession [
	self explicitRequirement
]
