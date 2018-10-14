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

{ #category : #'change reporting' }
TBlDrawingCache >> invalidRect: aBlBounds from: anElement [
	super invalidRect: aBlBounds from: anElement.
	
	self releaseCaches
]

{ #category : #'children hooks' }
TBlDrawingCache >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.

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
