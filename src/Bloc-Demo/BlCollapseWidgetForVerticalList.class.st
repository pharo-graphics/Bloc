Class {
	#name : #BlCollapseWidgetForVerticalList,
	#superclass : #BlElement,
	#instVars : [
		'collapsed',
		'header',
		'content'
	],
	#category : #'Bloc-Demo-Collapse'
}

{ #category : #'as yet unclassified' }
BlCollapseWidgetForVerticalList class >> exampleSimpleCollapse [

	<script>
	| collapse bgPaint collapsed collapsedChild |
	collapse := self new.
	"collapse position: 50 asPoint."

	bgPaint := BlLinearGradientPaint vertical
		           from: Color lightGreen
		           to: Color lightRed.

	collapsed := BlElement new
		             background: bgPaint;
		             "size: 350 @ 250;"
		             constraintsDo: [ :c | c horizontal matchParent.
			c vertical exact: 400 ];
		             border: (BlBorderBuilder new
				              paint: Color red;
				              width: 3;
				              dashed;
				              build);
		             addEventHandlerOn: BlClickEvent do: [ :e | e traceCr ];
		             yourself.

	collapsedChild := BlElement new
		                  background: Color purple;
		                  size: 50 @ 100;
		                  position: 50 asPoint;
		                  yourself.

	collapsed addChild: collapsedChild.

	collapse container addChild: collapsed.


	collapse openInSpace
]

{ #category : #accessing }
BlCollapseWidgetForVerticalList >> bar [ 
 
 ^ header
]

{ #category : #accessing }
BlCollapseWidgetForVerticalList >> bar: aBlElement [
 
 header := aBlElement 
]

{ #category : #'expanding-collapsing' }
BlCollapseWidgetForVerticalList >> collapse [ 

	| closedAnimation |
	closedAnimation := (BlTransformAnimation translate: 0@ (0- content height)) duration: 0.2 second.
	
	content addAnimation: closedAnimation.
]

{ #category : #accessing }
BlCollapseWidgetForVerticalList >> collapsed [ 

 ^ collapsed 
]

{ #category : #accessing }
BlCollapseWidgetForVerticalList >> container [ 

	^ content 
]

{ #category : #accessing }
BlCollapseWidgetForVerticalList >> container: aBlElement [ 

	content := aBlElement 
]

{ #category : #initialization }
BlCollapseWidgetForVerticalList >> initialize [

	super initialize.
	collapsed := true.
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ].
	self initializeHeader.
	self initializeContent
]

{ #category : #initialization }
BlCollapseWidgetForVerticalList >> initializeContent [

	content := BlElement new
		           layout: BlFrameLayout new;
		           constraintsDo: [ :c |
			           c vertical fitContent.
			           c horizontal matchParent ];
		           border: (BlBorder paint: Color veryLightGray width: 1);
		           yourself.

	self addChild: content
]

{ #category : #initialization }
BlCollapseWidgetForVerticalList >> initializeHeader [

	| arrow geometry rotateCWAnimation rotateACWAnimation |
	header := BlElement new
		       background: Color veryVeryLightGray;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 50 ];
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
		         size: geometry extent;
		         geometry: geometry;
		         constraintsDo: [ :c |
			         c frame vertical alignCenter.
			         c frame horizontal alignLeft ];
		         background: Color lightGray.

	header addChild: arrow.
	header clipChildren: false.

	rotateCWAnimation := (BlTransformAnimation rotate: 90) duration:
		                     0.2 second.
	rotateACWAnimation := (BlTransformAnimation rotate: -90) duration:
		                      0.2 second.


	header addEventHandlerOn: BlClickEvent do: [ :e |
		e consume.
		collapsed := collapsed not.
		collapsed
			ifTrue: [
				self show.
				arrow addAnimation: rotateCWAnimation copy ]
			ifFalse: [
				self collapse.
				arrow addAnimation: rotateACWAnimation copy ] ].

	self addChild: header
]

{ #category : #'host space - displaying' }
BlCollapseWidgetForVerticalList >> show [ 

	| openedAnimation | 
	openedAnimation := (BlTransformAnimation translate: 0@ content height) duration: 0.2 second.
	
	content addAnimation: openedAnimation.
]
