Class {
	#name : #BlCompositionPainterRepaintingWithTopLayerExamples,
	#superclass : #BlCompositionPainterRepaintingExamples,
	#category : #'Bloc-Compositor-Examples'
}

{ #category : #'repaint - examples' }
BlCompositionPainterRepaintingWithTopLayerExamples >> addScaledBackToWrapper [
	<gtExample>
	| aScripter |
	
	aScripter := self removeScaledFromWrapper.
	
	aScripter substeps: 'Add scaled back to wrapper' do: [ :aStep |
		aStep do
			label: 'Removed scaled element from wrapper';
			action: [ :anElement | anElement wrapper addChild: anElement scaled ];
			onSelf.

		aStep check
			label: 'Make sure that only the root needs paint in space';
			value: [ :aSpace | aSpace elementsNeedingPaint ] equals: [ :aSpace | { aSpace root children first } asSet ];
			onSpace.

		aStep check
			label: 'Parents of the scaled should be painted';
			equals: {
				aScripter element.
				aScripter element container.
				aScripter element wrapper.
				aScripter element scaled };
			onWithAllChildrenBreadthFirst;
			onSelected: [ :eachElement | eachElement needsPaint ].

		aStep do
			label: 'Perform layout';
			action: [ :aSpace | aSpace doLayout ];
			onSpace.

		aStep do
			label: 'Paint space the second time';
			action: [ :theScripter |
				"self haltOnce."
				theScripter userData
					at: #thirdRootLayer
					put: (BlCompositionPainter repaintSpace: theScripter space) ];
			onScripter.
			
		aStep do
			label: 'Clear elements that need paint';
			action: [ :aSpace | aSpace clearDirtyAreas ];
			onSpace.
			
		aStep check
			label: 'Make sure that there are no elements needing paint in space';
			value: [ :aSpace | aSpace elementsNeedingPaint ] equals: { } asSet;
			onSpace.
	
		aStep check
			label: 'Check that no elements need paint';
			allSatisfy: [ :eachElement | eachElement needsPaint not ];
			onWithAllChildrenBreadthFirst.
		
		aStep check
			label: 'Validate blue box composition layer';
			value: [ :anElement | anElement blueBox compositionLayer asSymbolTree ]
			equals: #(Offset
			  offset #(20 20)
			  ((Picture
			    cache true
			    simple true))).
		
		aStep check
			label: 'Validate red box composition layer';
			value: [ :anElement | anElement redBox compositionLayer asSymbolTree ]
			equals: #(Offset
			  offset #(20 80)
			  ((Picture
			    cache true
			    simple true)));
			onSelf.

		aStep check
			label: 'Validate shadow composition layer';
			value: [ :anElement | anElement shadow compositionLayer asSymbolTree ]
			equals: #(Offset
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
			    simple false)));
			onSelf.
		
		aStep check
			label: 'Validate the root layer';
			value: [ :theScripter | (theScripter userData at: #thirdRootLayer) asSymbolTree ]
			equals:
				#(Offset
				  offset #(0 0)
				  ((Picture
				    cache false
				    simple true)
				  (Leftover
				    state #(#(#Clip #Rectangle))
				    ((Offset
				      offset #(0.0 0.0)
				      ((Picture
				        cache false
				        simple true)
				      (Clip
				        offset #(0 0)
				        path #Rectangle
				        ((Picture
				          cache false
				          simple true)
				        (Leftover
				          state #(#(#Clip #Rectangle) #(#Clip #Rectangle))
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
				          simple true)))))))));
			onScripter ].
	
	^ aScripter syncContinue
]

{ #category : #'repaint - examples' }
BlCompositionPainterRepaintingWithTopLayerExamples >> paintFirstTime [
	<gtExample>
	| aScripter |
	
	aScripter := self scripter.

	aScripter substeps: 'First paint' do: [ :aStep |
		aStep do
			label: 'Add an element to the space';
			action: [ :theScripter | theScripter element: self scripterElement beInSeparateCompositionLayer ];
			onScripter.
		
		aStep check
			label: 'Check that initially all elements need paint';
			allSatisfy: [ :eachElement | eachElement needsPaint ];
			onWithAllChildrenBreadthFirst.
	
		aStep check
			label: 'Make sure that only the top element is added to elements needing paint';
			value: [ :aSpace | aSpace elementsNeedingPaint ] equals: [ :aSpace | { aSpace root } asSet ];
			onSpace.
		
		aStep do
			label: 'Perform layout';
			action: [ :aSpace | aSpace doLayout ];
			onSpace.
		
		aStep check
			label: 'Elements with composition layer need repaint';
			value: [ :aSpace | aSpace elementsNeedingPaint ] equals: [ :aSpace | { aSpace root } asSet ];
			onSpace.

		aStep do
			label: 'Paint space the first time';
			action: [ :theScripter |
				theScripter userData
					at: #firstRootLayer
					put: (BlCompositionPainter repaintSpace: theScripter space) ];
			onScripter.
			
		aStep do
			label: 'Clear elements that need paint';
			action: [ :aSpace | aSpace clearDirtyAreas ];
			onSpace.
			
		aStep check
			label: 'Make sure that there are no elements needing paint in space';
			value: [ :aSpace | aSpace elementsNeedingPaint ] equals: { } asSet;
			onSpace.
	
		aStep check
			label: 'Check that no elements need paint';
			allSatisfy: [ :eachElement | eachElement needsPaint not ];
			onWithAllChildrenBreadthFirst.
		
		aStep check
			label: 'Validate blue box composition layer';
			value: [ :anElement | anElement blueBox compositionLayer asSymbolTree ]
			equals: #(Offset
			  offset #(20 20)
			  ((Picture
			    cache true
			    simple true))).
		
		aStep check
			label: 'Validate red box composition layer';
			value: [ :anElement | anElement redBox compositionLayer asSymbolTree ]
			equals: #(Offset
			  offset #(20 80)
			  ((Picture
			    cache true
			    simple true)));
			onSelf.

		aStep check
			label: 'Validate shadow composition layer';
			value: [ :anElement | anElement shadow compositionLayer asSymbolTree ]
			equals: #(Offset
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
			    simple false)));
			onSelf.
		
		aStep check
			label: 'Validate the root layer';
			value: [ :theScripter | (theScripter userData at: #firstRootLayer) asSymbolTree ]
			equals:
				#(Offset
				  offset #(0 0)
				  ((Picture
				    cache false
				    simple true)
				  (Leftover
				    state #(#(#Clip #Rectangle))
				    ((Offset
				      offset #(0.0 0.0)
				      ((Picture
				        cache false
				        simple true)
				      (Clip
				        offset #(0 0)
				        path #Rectangle
				        ((Picture
				          cache false
				          simple true)
				        (Leftover
				          state #(#(#Clip #Rectangle) #(#Clip #Rectangle))
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
				          simple true)))))))));
			onScripter ].

	^ aScripter syncContinue
]

{ #category : #'repaint - examples' }
BlCompositionPainterRepaintingWithTopLayerExamples >> removeScaledFromWrapper [
	<gtExample>
	| aScripter |
	
	aScripter := self paintFirstTime.
	
	aScripter substeps: 'Repaint red box' do: [ :aStep |
		aStep do
			label: 'Removed scaled element from wrapper';
			action: [ :anElement | anElement wrapper removeChild: anElement scaled ];
			onSelf.

		aStep check
			label: 'Make sure that only the top element needs paint in space';
			value: [ :aSpace | aSpace elementsNeedingPaint ] equals: [ :aSpace | { aSpace root children first } asSet ];
			onSpace.

		aStep check
			label: 'Parents of the scaled should be painted';
			equals: { aScripter element . aScripter element container . aScripter element wrapper };
			onWithAllChildrenBreadthFirst;
			onSelected: [ :eachElement | eachElement needsPaint ].

		aStep do
			label: 'Perform layout';
			action: [ :aSpace | aSpace doLayout ];
			onSpace.

		aStep do
			label: 'Paint space the second time';
			action: [ :theScripter |
				theScripter userData
					at: #secondRootLayer
					put: (BlCompositionPainter repaintSpace: theScripter space) ];
			onScripter.
		
		aStep do
			label: 'Clear elements that need paint';
			action: [ :aSpace | aSpace clearDirtyAreas ];
			onSpace.
			
		aStep check
			label: 'Make sure that there are no elements needing paint in space';
			value: [ :aSpace | aSpace elementsNeedingPaint ] equals: { } asSet;
			onSpace.
		
		aStep check
			label: 'Validate the root layer';
			value: [ :theScripter | (theScripter userData at: #secondRootLayer) asSymbolTree ]
			equals:
				#(Offset
				  offset #(0 0)
				  ((Picture
				    cache false
				    simple true)
				  (Leftover
				    state #(#(#Clip #Rectangle))
				    ((Offset
				      offset #(0.0 0.0)
				      ((Picture
				        cache false
				        simple true)
				      (Clip
				        offset #(0 0)
				        path #Rectangle
				        ((Picture
				          cache true
				          simple true)))))))));
			onScripter.
		
		aStep check
			label: 'Red box does not have composition layer anymore';
			value: [ :anElement | anElement redBox compositionLayer ] equals: nil.
		
		aStep check
			label: 'Blue box does not have composition layer anymore';
			value: [ :anElement | anElement blueBox compositionLayer ] equals: nil.
			
		aStep check
			label: 'Scaled / shadow does not have composition layer anymore';
			value: [ :anElement | anElement scaled compositionLayer ] equals: nil ].
	
	^ aScripter syncContinue
]

{ #category : #'repaint - examples' }
BlCompositionPainterRepaintingWithTopLayerExamples >> repaintRedBox [
	<gtExample>
	| aScripter |
	
	aScripter := self paintFirstTime.
	
	aScripter substeps: 'Repaint red box' do: [ :aStep |
		aStep do
			label: 'Change background of the red box';
			action: [ :anElement | anElement redBox background: Color paleMagenta ];
			onSelf.

		aStep check
			label: 'Make sure that only the red box needs paint in space';
			value: [ :aSpace | aSpace elementsNeedingPaint ] equals: [ :aSpace | { aSpace root children first redBox } asSet ];
			onSpace.

		aStep check
			label: 'Only red box needs to be painted';
			equals: { aScripter element redBox };
			onWithAllChildrenBreadthFirst;
			onSelected: [ :eachElement | eachElement needsPaint ].
			
		aStep do
			label: 'Paint space the second time';
			action: [ :theScripter |
				theScripter userData
					at: #secondRootLayer
					put: (BlCompositionPainter repaintSpace: theScripter space) ];
			onScripter ].
	
	^ aScripter syncContinue
]
