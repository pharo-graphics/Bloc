Extension { #name : #BlElement }

{ #category : #'*Bloc-Sparta' }
BlElement >> asSpartaForm [
	| aCanvas aBoundsInParent aBoundsInLocal |

	self forceLayout.

	aBoundsInLocal := (self effectBounds: BlBounds new)
		merge: self boundsInLocal;
		merge: self visualBounds.

	aBoundsInParent := self localBoundsToParent: aBoundsInLocal copy.

	aCanvas := Bloc preferableSpartaCanvas extent: (aBoundsInParent extent max: 1@1).

	aCanvas transform
		by: [ :aTransform | aTransform translateBy: aBoundsInParent origin negated]
		during: [ self fullDrawOnSpartaCanvas: aCanvas ].

	^ aCanvas asForm
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawBackgroundOnSpartaCanvas: aCanvas [
	self background drawOnSpartaCanvas: aCanvas of: self
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawBorderOnSpartaCanvas: aCanvas [
	self border drawOnSpartaCanvas: aCanvas of: self
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawChildrenOnSpartaCanvas: aCanvas [

	"If there are not children no need to draw and clip"
	self hasChildren
		ifFalse: [ ^ self ].

	aCanvas clip
		when: [ self clipChildren ]
		by: [ self geometry pathOnSpartaCanvas: aCanvas ]
		during: [ self children sortedByElevation
			do: [ :anElement | anElement fullDrawOnSpartaCanvas: aCanvas ] ]
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawDebugInfoOnSpartaCanvas: aCanvas [
	| aWidth |

	aWidth := (self globalBoundsToLocal: (BlBounds origin: 0@0 extent: 1@1)) width.

	aCanvas stroke
		path: self geometryBounds;
		paint: (Color red alpha: 0.5);
		dashPattern: { aWidth * 6 . aWidth * 6 };
		width: aWidth;
		draw.

	aCanvas stroke
		path: self visualBounds;
		paint: (Color blue alpha: 0.5);
		width: aWidth;
		draw.
		
	aCanvas stroke
		path: self bounds inLocal asRectangle;
		paint: (Color gray alpha: 0.5);
		dashPattern: { aWidth * 6 . aWidth * 6 };
		width: aWidth;
		draw
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawError: anError onSpartaCanvas: aCanvas [

	aCanvas fill
		paint: Color lightGray;
		path: self boundsInLocal;
		draw.

	self drawChildrenOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawMeAndChildrenOnSpartaCanvas: aCanvas [
	self drawOnSpartaCanvas: aCanvas.
	self drawChildrenOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawOnSpartaCanvas: aCanvas [
	| isBackgroundTransparent isBorderTransparent areBothTransparent areBothVisible |
	
	isBackgroundTransparent := self background isTransparent.
	isBorderTransparent := self border isTransparent.
	areBothTransparent := isBackgroundTransparent and: [ isBorderTransparent ].
	areBothVisible := (isBackgroundTransparent or: [ isBorderTransparent ]) not.

	areBothTransparent
		ifTrue: [ ^ self ].

	"We create a new virtual layer in order to blend background and border only if they are both visible"
	aCanvas layer
		when: [ self outskirts wantsLayerOn: self ]
		during: [
			aCanvas
				compose: #composeSource
				when: [ self outskirts wantsLayerOn: self ]
				during: [
					self outskirts
						drawBackground: [ self drawBackgroundOnSpartaCanvas: aCanvas ]
						border: [ self drawBorderOnSpartaCanvas: aCanvas ]
						of: self
						onSpartaCanvas: aCanvas ] ]
]

{ #category : #'*Bloc-Sparta' }
BlElement >> fullDrawOnSpartaCanvas: aCanvas [
	| anEffectBounds |

	"We do not draw transparent elements at all"
	self isTransparent
		ifTrue: [ ^ self ].

	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [ ^ self ].

	anEffectBounds := self effectBounds: BlBounds new.
	"No need to render elements smaller than half of a pixel"
	(anEffectBounds width min: anEffectBounds height) < 0.5
		ifTrue: [ ^ self ].

	(aCanvas clip containsLocal: (self localBoundsToParent: anEffectBounds copy))
		ifFalse: [ ^ self ].

	aCanvas layer
		alpha: self opacity;
		when: [ self isTranslucent ]
		during: [
			aCanvas transform
				by: self transformation
				translated: self position
				during: [ :aTransformedCanvas |
					self errorHandler
						with: self
						do: [
							aTransformedCanvas clip
								when: [ self clipChildren ]
								by: [ (self visualBounds: BlBounds new on: aTransformedCanvas) merge: anEffectBounds ]
								during: [
									self effect
										applyEffectOnSpartaCanvas: aTransformedCanvas
										for: self
										around: [ :aShadowCanvas | self drawMeAndChildrenOnSpartaCanvas: aShadowCanvas ] ].
								misc debug ifTrue: [
									self drawDebugInfoOnSpartaCanvas: aTransformedCanvas ] ]
						failed: [ :anError | self drawError: anError onSpartaCanvas: aCanvas ] ] ]
]
