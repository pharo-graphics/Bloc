Extension { #name : #BlElementVectorGeometry }

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ self subclassResponsibility
]

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> containsPoint: aPoint in: aBlElement [
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"

	^ aBlElement isAttachedToSceneGraph
		ifTrue: [
			aBlElement space containsPoint: aPoint in: aBlElement ]
		ifFalse: [
			self
				containsPoint: aPoint
				in: aBlElement
				onSpartaCanvas: Bloc preferableSpartaCanvas offscreen ]

]

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> containsPoint: aPoint in: anElement onSpartaCanvas: aSpartaCanvas [
	"Note: I am a fallback method to determine if a point lies within a geometry path
	when geometry is complex and it is mathematically difficult to compute manually"

	| aPath |
	aPath := pathCache pathOnSpartaCanvas: aSpartaCanvas.
	^ aSpartaCanvas fill
		path: aPath;
		containsPoint: aPoint
]

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> pathOnSpartaCanvas: aCanvas of: aBlElement [
	<return: #TSpartaPath>
	
	^ pathCache pathOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	<return: #BlBounds>

	^ aBlBounds rectangle: (pathCache strokedBounds: aBlBounds of: anElement on: aCanvas)
]

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> strokedBoundsCentered: aBlBounds of: anElement on: aCanvas [
	| spartaPath strokeOptions strokedBounds |

	spartaPath := anElement geometry pathOnSpartaCanvas: aCanvas of: anElement.
	strokeOptions := aCanvas stroke
		width: (anElement border width max: 1);
		in: [ :aPainter | anElement border style applyOn: aPainter ];
		strokeOptions.

	strokedBounds := spartaPath strokedBoundsOn: aCanvas with: strokeOptions.
	^ aBlBounds rectangle: strokedBounds
]

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> strokedBoundsInside: aBlBounds of: anElement on: aCanvas [
	"Stroked inside bounds property is equal to geometry bounds"
	<return: #BlBounds>

	^ self geometryBounds: aBlBounds
]

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> strokedBoundsOutside: aBlBounds of: anElement on: aCanvas [
	| spartaPath strokeOptions strokedBounds |

	spartaPath := anElement geometry pathOnSpartaCanvas: aCanvas of: anElement.
	strokeOptions := aCanvas stroke
		in: [ :aPainter | anElement border style applyOn: aPainter ];
		width: ((anElement border width * 2.0) max: 1);
		strokeOptions.

	strokedBounds := spartaPath strokedBoundsOn: aCanvas with: strokeOptions.
	^ aBlBounds rectangle: strokedBounds
]
