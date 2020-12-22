Extension { #name : #BlCompositionLayer }

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionLayer >> asExplosionElement [
	<return: #BlElement>
	| aContainer theBounds |

	aContainer := BlElement new.
	aContainer clipChildren: false.
	aContainer constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	
	theBounds := nil.
	
	self pictureLayersDo: [ :eachPictureLayer |
		| aPictureElement pictureBounds |
		
		pictureBounds := (BlBounds fromRectangle: eachPictureLayer picture bounds).
		
		aPictureElement := eachPictureLayer asElement.
		
		eachPictureLayer needsCache
			ifTrue: [ aPictureElement background: (Color gray alpha: 0.15) ].
		aPictureElement zIndex: eachPictureLayer depth.
		aPictureElement transformDo: [ :t |
			t
				topLeftOrigin;
					matrix: eachPictureLayer totalMatrix;
					scaleBy: 0.8@1;
					skewX: 30;
					rotateBy: 30;
					translateBy: (0 @ 30) negated * eachPictureLayer depth ].
	
		aPictureElement localBoundsToParent: pictureBounds.
		theBounds
			ifNil: [ theBounds := pictureBounds ]
			ifNotNil: [ theBounds merge: pictureBounds ].
		
		aContainer addChild: aPictureElement ].
	
	^ theBounds
		ifNil: [ aContainer ]
		ifNotNil: [
			| aWrapper |			
			aContainer size: theBounds extent.
			aContainer transformDo: [ :t | t translateBy: theBounds origin negated ].
			
			aWrapper := BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				addChild: aContainer.
				
			aWrapper asScalableElement ]
]

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionLayer >> gtExplosionLayersFor: aView [
	<gtView>

	^ aView explicit
		title: 'Layers';
		priority: 5;
		stencil: [ self asExplosionElement ]
]

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionLayer >> gtPreviewFor: aView [
	<gtView>

	^ aView sparta
		title: 'Preview';
		priority: 3;
		matchParent;
		rendering: [ :aCanvas |
			| aSkiaLayer |
			aSkiaLayer := self asSkiaLayer.
			SkiaCompositor newDuring: [ :aCompositor | aCompositor draw: aSkiaLayer on: aCanvas ] ]
]

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionLayer >> gtSymbolTreeFor: aView [
	<gtView>
	
	^ aView textEditor
		title: 'Tree Print';
		priority: 4;
		look: BrGlamorousCodeEditorLook;
		text: [ self class printSymbolTree: self asSymbolTree ]
]

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionLayer >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tree';
		priority: 2;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionLayer >> paintTreeWith: view [
	view nodes
		shape: [ :each |
			BlElement new
				layout: (BlLinearLayout vertical alignCenter);
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				background: Color white;
				when: BlClickEvent do: [ :anEvent | anEvent currentTarget phlow spawnObject: each ];
				padding: (BlInsets all: 10);
				zIndex: 10;
				addChild: (BlTextElement new
					padding: (BlInsets top: 5 left: 8 bottom: 5 right: 8);
					border: (((each isKindOf: BlCompositionPictureLayer) and: [ each isWorthCaching ])
						ifTrue: [ BlBorder paint: Color red width: 1 ]
						ifFalse: [ BlBorder paint: Color gray width: 1 ]);
					text: each name asRopedText glamorousRegularFontAndSize);
				in: [ :aNodeElement |
					(each isKindOf: BlCompositionPictureLayer)
						ifTrue: [
							| aForm aFormElement |
							
							aForm := each asForm.
							aFormElement := each asForm asElement asScalableElement
								background: Color white;
								margin: (BlInsets top: 10);
								look: BrShadowLook new.
								
							aForm width > aForm height
								ifTrue: [
									aFormElement
										fitWidth;
										constraintsDo: [ :c |
											c horizontal exact: 100.
											c vertical fitContent ] ]
								ifFalse: [
									aFormElement
										fitHeight;
										constraintsDo: [ :c |
											c horizontal fitContent.
											c vertical exact: 100 ] ].							
							aNodeElement addChild: aFormElement ]
				];
				yourself ];
		with: (self withDeepCollect: #children).
	view edges
		fromNearestBounds;
		toNearestBounds;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #children.
	view layout tree 
		nodeDistance: 10;
		levelDistance: 20
]
