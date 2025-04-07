"
I represent a leaf parent node.
"
Class {
	#name : #BlLayoutParentNode,
	#superclass : #BlAbstractLayoutParentNode,
	#instVars : [
		'children',
		'extentSpec',
		'constraints',
		'extent',
		'position'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'instance creation' }
BlLayoutParentNode class >> alreadyMeasured: aBlElement [

	^ self new
		constraints: aBlElement constraints;
		children:
			(aBlElement children accountedByLayout collect: [ :eachChild |
				| aTransformation eachNode |
				aTransformation := self getTransformation: eachChild.
					
				eachNode := BlLayoutChildNode new
					constraints: eachChild constraints;
					measurement: (BlLayoutNodeComputedMeasurement
						position: eachChild constraints position
						extent: eachChild measuredExtent);
					yourself.
				
				aTransformation ifNotNil: [
					eachNode := eachNode withTransformation: aTransformation ].

				eachNode withElement: eachChild ]);
		yourself
]

{ #category : #'instance creation' }
BlLayoutParentNode class >> alreadyMeasuredWithoutTransformation: aBlElement [

	^ self new
		constraints: aBlElement constraints;
		children:
			(aBlElement children accountedByLayout collect: [ :eachChild |
				(BlLayoutChildNode new
					constraints: eachChild constraints;
					measurement:
						(BlLayoutNodeComputedMeasurement
							position: eachChild constraints position
							extent: eachChild measuredExtent);
					yourself) withElement: eachChild ]);
		yourself
]

{ #category : #'instance creation' }
BlLayoutParentNode class >> getParentTransformation: anElement [
	| aTransformation |

	aTransformation := anElement layout isInfluencedByTransformation
		ifTrue: [ anElement transformation asElementTransformation ]
		ifFalse: [ nil ].

	aTransformation := (aTransformation isNil or: [ aTransformation isIdentity ])
		ifTrue: [ nil ]
		ifFalse: [ aTransformation ].

	^ aTransformation
]

{ #category : #'instance creation' }
BlLayoutParentNode class >> getTransformation: anElement [
	| aTransformation |

	aTransformation := anElement constraints shouldAccountTransformation
		ifTrue: [ anElement transformation asElementTransformation. ]
		ifFalse: [ nil ].
	aTransformation := (aTransformation isNil or: [ aTransformation isIdentity ])
		ifTrue: [ nil ]
		ifFalse: [ aTransformation ].

	^ aTransformation
]

{ #category : #'instance creation' }
BlLayoutParentNode class >> toMeasure: aBlElement [
	| anElementTransformation aParentNode |
	
	anElementTransformation := self getParentTransformation: aBlElement.
	aParentNode := self new
		constraints: aBlElement constraints;
		children:
			(aBlElement children accountedByLayout collect: [ :eachChild |
				| aTransformation eachNode |
				aTransformation := self getTransformation: eachChild.
				
				eachNode := BlLayoutChildNode new
					constraints: eachChild constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: eachChild);
					yourself.

				aTransformation ifNotNil: [
					eachNode := eachNode withTransformation: aTransformation ].

				eachNode withElement: eachChild ]);
		yourself.
			
	anElementTransformation ifNotNil: [
		aParentNode := aParentNode withTransformation: anElementTransformation ].
	
	^ aParentNode
]

{ #category : #accessing }
BlLayoutParentNode >> children [

	^ children
]

{ #category : #accessing }
BlLayoutParentNode >> children: aCollectionOfChildNodes [

	children := aCollectionOfChildNodes as: BlLayoutNodeChildren.
	children do: [ :eachChild | eachChild parent: self parent ]
]

{ #category : #accessing }
BlLayoutParentNode >> constraints [

	^ constraints
]

{ #category : #accessing }
BlLayoutParentNode >> constraints: aBlLayoutConstraints [

	constraints := aBlLayoutConstraints
]

{ #category : #'api - geometry' }
BlLayoutParentNode >> extent [

	^ extent
]

{ #category : #'api - geometry' }
BlLayoutParentNode >> extent: aPoint [

	extent := aPoint
]

{ #category : #'api - extent spec' }
BlLayoutParentNode >> extentSpec [

	^ extentSpec
]

{ #category : #accessing }
BlLayoutParentNode >> extentSpec: anObject [

	extentSpec := anObject
]

{ #category : #initialization }
BlLayoutParentNode >> initialize [

	super initialize.

	children := #(  ).
	position := 0.0 @ 0.0.
	extent := 0.0 @ 0.0
]

{ #category : #accessing }
BlLayoutParentNode >> parent [

	^ self
]

{ #category : #accessing }
BlLayoutParentNode >> position [

	^ position
]

{ #category : #accessing }
BlLayoutParentNode >> position: aPoint [

	position := aPoint
]

{ #category : #accessing }
BlLayoutParentNode >> transformationDo: aBlock [

	
]

{ #category : #'api - converting' }
BlLayoutParentNode >> withFilter: aSelectBlock [

	^ BlLayoutParentNodeWithFilter new
		  parentNode: self;
		  filterBlock: aSelectBlock;
		  children: (self children select: aSelectBlock);
		  yourself
]

{ #category : #'api - converting' }
BlLayoutParentNode >> withTransformation: aBlElementTransformation [

	^ BlLayoutParentNodeWithTransformation new
		  parentNode: self;
		  transformation: aBlElementTransformation;
		  yourself
]
