Extension { #name : #BlTelemetryTask }

{ #category : #'*Bloc-Extensions' }
BlTelemetryTask >> gtBarElements [
	^ self gtBarElementsWithGlobalWeight: 1.0 local: 1.0
]

{ #category : #'*Bloc-Extensions' }
BlTelemetryTask >> gtBarElementsWithGlobalWeight: aWeight local: aLocalWeight [
	| taskElements |
	
	taskElements := aWeight > 0.1
		ifTrue: [
			| myDuration |		
			myDuration := self duration.
	
			self tasks collect: [ :eachTask |
				| eachWeight |
				
				eachWeight := myDuration isZero
					ifTrue: [ 0 ]
					ifFalse: [ (eachTask duration / myDuration) asFloat ].
				(eachTask gtBarElementsWithGlobalWeight: eachWeight * aWeight local: eachWeight)
					constraintsDo: [ :c | c linear weight: (eachWeight max: 0.001) ] ] ]
		ifFalse: [
			self tasks
				ifEmpty: [ #() ]
				ifNotEmpty: [ {
					BrHorizontalPane new
						when: BlClickEvent
						do: [ :anEvent |
							anEvent consumed: true.
							anEvent currentTarget phlow spawnObject: self ];
						vExact: 20;
						hMatchParent;
						geometry: (BlRectangle cornerRadius: 3);
						border: (BlBorder paint: Color transparent width: (aWeight max: 0.1));
						background: (Color gray alpha: 0.2) } ] ].
	
	^ BrVerticalPane new
		hMatchParent;
		vFitContent;
		addChild: (BrHorizontalPane new
			when: BlClickEvent
			do: [ :anEvent |
				anEvent consumed: true.
				anEvent currentTarget phlow spawnObject: self ];
			hMatchParent;
			alignCenter;
			vExact: 20;
			padding: (BlInsets top: 3 bottom: 3);
			geometry: (BlRectangle cornerRadius: 3);
			border: (BlBorder paint: Color transparent width: 0.25);
			background: ((BlColorTransition interpolate: Color gray to: Color red at: aWeight) alpha: 0.4 + (20 atRandom / 100.0));
			in: [ :aPane | aWeight > 0.005
				ifTrue: [ aPane addChild: (BrLabel new
					look: (BrGlamorousLabelLook new fontSize: 10);
					text: self printString) asScalableElement ] ];
			yourself);
		addChild: (BrHorizontalPane new
			alignTopCenter;
			hMatchParent;
			vFitContent;
			weightSum: 1;
			addChildren: taskElements);
		yourself
]

{ #category : #'*Bloc-Extensions' }
BlTelemetryTask >> gtMapFor: aView [
	<gtView>

	^ aView explicit
		title: 'Map';
		priority: 1;
		stencil: [ self gtBarElements ]
]

{ #category : #'*Bloc-Extensions' }
BlTelemetryTask >> gtNestedTree [
	^ self tasks
		ifEmpty: [
			GtNestedTreeNode new
				name: self name;
				leaves: {
					GtNestedTreeItemLeaf new 
					item: self;
					weight: [ :aTask | aTask durationInMilliseconds ] } ]
		ifNotEmpty: [ :theTasks |
			GtNestedTreeNode new 
				name: self name;
				nodes: (theTasks collect: [ :eachTask | eachTask gtNestedTree ] as: Array) ]
]

{ #category : #'*Bloc-Extensions' }
BlTelemetryTask >> gtTreeFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Tree';
		priority: 2;
		object: [ self gtNestedTree ];
		view: #gtTreeFor:
]
