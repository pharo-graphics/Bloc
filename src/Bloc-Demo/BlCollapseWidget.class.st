Class {
	#name : #BlCollapseWidget,
	#superclass : #BlElement,
	#instVars : [
		'bar',
		'container',
		'collapsed'
	],
	#category : #'Bloc-Demo-Collapse'
}

{ #category : #'as yet unclassified' }
BlCollapseWidget class >> exampleSimpleCollapse [

	<script>
	| collapse bgPaint collapsed collapsedChild |
	collapse := self new.
	collapse position: 50 asPoint.

	bgPaint := BlLinearGradientPaint vertical
		           from: Color lightGreen
		           to: Color lightRed.

	collapsed := BlElement new
		             background: bgPaint;
		             extent: 250 @ 150;
		             border: (BlBorderBuilder new
				              paint: Color red;
				              width: 3;
				              dashed;
				              build);
		             addEventHandlerOn: BlClickEvent do: [ :e | e traceCr ];
		             yourself.

	collapsedChild := BlElement new
		                  background: Color purple;
		                  extent: 50 @ 100;
		                  position: 50 asPoint;
		                  yourself.

	collapsed addChild: collapsedChild.

	collapse container addChild: collapsed.

	collapse openInSpace
]

{ #category : #accessing }
BlCollapseWidget >> bar [ 
 
 ^ bar
]

{ #category : #accessing }
BlCollapseWidget >> bar: aBlElement [
 
 bar := aBlElement 
]

{ #category : #'expanding-collapsing' }
BlCollapseWidget >> collapse [ 

	| closedAnimation |
	closedAnimation := (BlTransformAnimation translate: 0@ (0- container height)) duration: 0.2 second.
	
	container addAnimation: closedAnimation.
]

{ #category : #accessing }
BlCollapseWidget >> collapsed [ 

 ^ collapsed 
]

{ #category : #accessing }
BlCollapseWidget >> container [ 

	^ container 
]

{ #category : #accessing }
BlCollapseWidget >> container: aBlElement [ 

	container := aBlElement 
]

{ #category : #initialization }
BlCollapseWidget >> initialize [ 

	super initialize.
	collapsed := true.
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent ].
	self initializeBar.
	self initializeContainer.
]

{ #category : #initialization }
BlCollapseWidget >> initializeBar [

	| arrow geometry opened rotateCWAnimation rotateACWAnimation |
	bar := BlElement new
		       background: Color veryVeryLightGray;
		       extent: 250 @ 50;
		       border: (BlBorder paint: Color lightGray width: 2);
		       layout: BlFrameLayout new;
		       padding: (BlInsets all: 10);
		       zIndex: 1;
		       "has to be 'above' the container"yourself.

	geometry := BlPolygonGeometry vertices: {
			            (0 @ 0).
			            (20 @ 0).
			            (10 @ 10) }.

	arrow := BlElement new
		         extent: geometry extent;
		         geometry: geometry;
		         constraintsDo: [ :c |
			         c frame vertical alignCenter.
			         c frame horizontal alignLeft ];
		         background: Color lightGray.

	bar addChild: arrow.
	bar clipChildren: false.

	rotateCWAnimation := (BlTransformAnimation rotate: 90) duration:
		                     0.2 second.
	rotateACWAnimation := (BlTransformAnimation rotate: -90) duration:
		                      0.2 second.


	bar addEventHandlerOn: BlClickEvent do: [ :e |
			       e consume.
			       collapsed := collapsed not.
			       collapsed
				       ifTrue: [ self show.
					 arrow addAnimation: rotateCWAnimation copy]
				       ifFalse: [ self collapse.
					 arrow addAnimation: rotateACWAnimation copy] ].

	self addChild: bar
]

{ #category : #initialization }
BlCollapseWidget >> initializeContainer [ 

	container := BlElement new 
		constraintsDo: [ :c | 
			c vertical exact: 150.
			c horizontal matchParent ];
		border: (BlBorder paint: Color veryLightGray width: 1);
		yourself.
		
	self addChild: container
]

{ #category : #'host space - displaying' }
BlCollapseWidget >> show [ 

	| openedAnimation | 
	openedAnimation := (BlTransformAnimation translate: 0@ container height) duration: 0.2 second.
	
	container addAnimation: openedAnimation.
]
