"
A couple of example on the transform possibility in bloc
- rotating
- translating
- scaling.
"
Class {
	#name : #TransformExperiment,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-Bloc'
}

{ #category : #examples }
TransformExperiment class >> transformBlBasicLayout [

	<sampleInstance>
	| child parent |
	child := BlElement new
		         background: Color lightBlue;
		         geometry: BlCircleGeometry new;
		         yourself.

	child position: 100 @ 100.

	parent := BlElement new
		          size: 200 asPoint;
		          addChild: child;
		          background: Color lightRed.

	parent whenLayoutedDoOnce: [
		child transformDo: [ :t | t translateBy: child size negated / 2 ] ].

	parent openInSpace.
	^parent.
]

{ #category : #examples }
TransformExperiment class >> transformExample [

	<sampleInstance>
	| container node |
	container := BlElement new
		              layout: BlFrameLayout new;
		              constraintsDo: [ :c |
			              c horizontal fitContent.
			              c vertical fitContent ];
		              padding: (BlInsets all: 20);
		              background: (Color gray alpha: 0.2).

	node := BlElement new
		        geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		        border: (BlBorder paint: Color black width: 2);
		        background: Color white;
		        constraintsDo: [ :c |
			        c frame horizontal alignCenter.
			        c frame vertical alignCenter ];
		        size: 20 @ 20.

	container transformDo: [ :t |
		t
			scaleBy: 2.0;
			rotateBy: 69;
			translateBy: 50 @ 50 ].

	container whenLayoutedDoOnce:  [ container addChild: node.].

	container openInNewSpace. 
	^ container
]

{ #category : #'see class side' }
TransformExperiment >> seeClassSide [ 
]
