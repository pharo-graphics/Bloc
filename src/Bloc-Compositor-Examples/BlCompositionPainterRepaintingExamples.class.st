Class {
	#name : #BlCompositionPainterRepaintingExamples,
	#superclass : #Object,
	#category : #'Bloc-Compositor-Examples'
}

{ #category : #'repaint - examples' }
BlCompositionPainterRepaintingExamples >> paintFirstTime [
	<gtExample>
	| anElement aPainter |
	
	anElement := BCompositionExampleElementWithMultipleLayersAndTransformation new.
	anElement forceLayout.
	
	aPainter := BlCompositionLayeredPainter root: anElement transformedBounds extent.
	anElement fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.
	
	self assert: (anElement withAllChildrenBreadthFirst allSatisfy: [ :eachElement | eachElement needsPaint not ]).
	
	self assert: aPainter containerLayer asSymbolTree equals:
		#(Container
		  ((Picture
		    cache false
		    simple true)
		  (Leftover
		    state #(#(#Clip #Rectangle) #(#Clip #Rectangle) #(#Clip #Rectangle))
		    ((Offset
		      offset #(160.0 110.0)
		      ((Picture
		        cache false
		        simple true)
		      (Leftover
		        state #(#(#Transform #(1.5 0.0 -70.0 0.0 1.5 -45.0 0 0 1)))
		        ((Shadow
		          offset #(0 0)
		          shadowOffset #(10 20)
		          shadowColor #(0.0 0.0 0.0 0.2980392156862745)
		          shadowWidth 15
		          shadowPath #Rectangle
		          ((Picture
		            cache true
		            simple true)))))
		      (Picture
		        cache false
		        simple true)
		      (Leftover
		        state #(#(#Transform #(1.5 0.0 -70.0 0.0 1.5 -45.0 0 0 1)) #(#Clip #Rectangle))
		        ((Offset
		          offset #(20 20)
		          ((Picture
		            cache true
		            simple true)))))
		      (Leftover
		        state #(#(#Transform #(1.5 0.0 -70.0 0.0 1.5 -45.0 0 0 1)) #(#Clip #Rectangle))
		        ((Offset
		          offset #(20 80)
		          ((Picture
		            cache true
		            simple true)))))
		      (Picture
		        cache false
		        simple false)))))
		  (Picture
		    cache false
		    simple true))).
	
	^ anElement
]

{ #category : #'repaint - examples' }
BlCompositionPainterRepaintingExamples >> repaintRedBox [
	<gtExample>
	| anElement aPainter aRootLayer aBackgroundLayer aPreviousBlueLayer aBlueOffsetLayer aPreviousRedLayer aRedOffsetLayer |
	
	anElement := self paintFirstTime.
	anElement forceLayout.

	anElement redBox background: Color paleMagenta.

	self assert: anElement needsPaint not.
	self assert: anElement container needsPaint not.
	self assert: anElement rightCircle needsPaint not.

	self assert: anElement leftCircle needsPaint not.
	self assert: anElement wrapper needsPaint not.
	self assert: anElement scaled needsPaint not.
	self assert: anElement blueBox needsPaint not.
	self assert: anElement redBox needsPaint.
	self assert: anElement grayBox needsPaint not.

	"aPreviousBlueLayer := anElement blueBox compositionLayer.
	self assert: aPreviousBlueLayer notNil.
	aPreviousRedLayer := anElement redBox compositionLayer.
	self assert: aPreviousRedLayer isNil."

	aPainter := BlCompositionLayeredPainter root: anElement transformedBounds extent.
	anElement fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.

	aRootLayer := aPainter containerLayer.	

	"self assert: aRootLayer layers size equals: 4."

	"aBackgroundLayer := aRootLayer layers first.
	self assert: (aBackgroundLayer isKindOf: BlCompositionPictureLayer).
	self assert: aBackgroundLayer needsCache not.

	self assert: (aRootLayer layers second isKindOf: BlCompositionLeftoverStateLayer).
	self assert: (aRootLayer layers third isKindOf: BlCompositionLeftoverStateLayer).

	aBlueOffsetLayer := aRootLayer layers second layers first.
	self assert: aPreviousBlueLayer == aBlueOffsetLayer.
	self assert: (aBlueOffsetLayer isKindOf: BlCompositionOffsetLayer).
	self assert: anElement blueBox compositionLayer == aBlueOffsetLayer.
	self assert: aBlueOffsetLayer offset equals: 20@20.

	aRedOffsetLayer := aRootLayer layers third layers first.
	self assert: (aRedOffsetLayer isKindOf: BlCompositionOffsetLayer).
	self assert: anElement redBox compositionLayer == aRedOffsetLayer.
	self assert: aRedOffsetLayer offset equals: 20@80.
	
	self assert: (aRootLayer layers fourth isKindOf: BlCompositionPictureLayer).
	self assert: aRootLayer layers fourth needsCache not."
	
	^ aRootLayer
]

{ #category : #'repaint - examples' }
BlCompositionPainterRepaintingExamples >> repaintRightCircle [
	<gtExample>
	| anElement aPainter aRootLayer aBackgroundLayer aPreviousBlueLayer aBlueOffsetLayer aPreviousRedLayer aRedOffsetLayer |
	
	anElement := self paintFirstTime.
	anElement forceLayout.

	anElement rightCircle background: Color red.

	"self assert: anElement needsPaint.
	self assert: anElement container needsPaint.
	self assert: anElement rightCircle needsPaint.

	self assert: anElement leftCircle needsPaint not.
	self assert: anElement wrapper needsPaint not.
	self assert: anElement scaled needsPaint not.
	self assert: anElement blueBox needsPaint not.
	self assert: anElement redBox needsPaint not.
	self assert: anElement grayBox needsPaint not.

	aPreviousBlueLayer := anElement blueBox compositionLayer.
	self assert: aPreviousBlueLayer notNil.
	aPreviousRedLayer := anElement redBox compositionLayer.
	self assert: aPreviousRedLayer notNil.

	aPainter := BlCompositionPainter root: anElement transformedBounds extent.
	anElement fullPaintOn: aPainter offset: 0@0.
	aPainter stopRecording.

	aRootLayer := aPainter containerLayer.	

	self assert: aRootLayer layers size equals: 4.

	aBackgroundLayer := aRootLayer layers first.
	self assert: (aBackgroundLayer isKindOf: BlCompositionPictureLayer).
	self assert: aBackgroundLayer needsCache not.

	self assert: (aRootLayer layers second isKindOf: BlCompositionLeftoverStateLayer).
	self assert: (aRootLayer layers third isKindOf: BlCompositionLeftoverStateLayer).

	aBlueOffsetLayer := aRootLayer layers second layers first.
	self assert: aPreviousBlueLayer == aBlueOffsetLayer.
	self assert: (aBlueOffsetLayer isKindOf: BlCompositionOffsetLayer).
	self assert: anElement blueBox compositionLayer == aBlueOffsetLayer.
	self assert: aBlueOffsetLayer offset equals: 20@20.

	aRedOffsetLayer := aRootLayer layers third layers first.
	self assert: aPreviousRedLayer == aRedOffsetLayer.
	self assert: (aRedOffsetLayer isKindOf: BlCompositionOffsetLayer).
	self assert: anElement redBox compositionLayer == aRedOffsetLayer.
	self assert: aRedOffsetLayer offset equals: 20@80.
	
	self assert: (aRootLayer layers fourth isKindOf: BlCompositionPictureLayer).
	self assert: aRootLayer layers fourth needsCache not."
	
	^ aRootLayer
]
