Class {
	#name : #BlLayoutParentNode,
	#superclass : #BlLayoutNode,
	#traits : 'TBlLayoutNode + TBlLayoutParentNode',
	#classTraits : 'TBlLayoutNode classTrait + TBlLayoutParentNode classTrait',
	#instVars : [
		'children',
		'extentSpec',
		'measuredExtent',
		'layoutExtent',
		'constraints'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'instance creation' }
BlLayoutParentNode class >> alreadyMeasured: aBlElement [
	^ self new
		constraints: aBlElement constraints;
		children: (
			aBlElement children accountedByLayout collect: [ :eachChild |
				| aTransformation eachNode |
				
				aTransformation := eachChild constraints shouldAccountTransformation
					ifTrue: [ eachChild transformation asElementTransformation. ]
					ifFalse: [ nil ].
				aTransformation := (aTransformation isNil or: [ aTransformation isIdentity ])
					ifTrue: [ nil ]
					ifFalse: [ aTransformation ].
					
				eachNode := BlLayoutChildNode new
					constraints: eachChild constraints;
					measurement: (BlLayoutNodeComputedMeasurement new
						position: eachChild constraints position;
						extent: eachChild measuredExtent).
				
				aTransformation
					ifNotNil: [ eachNode := eachNode withTransformation: aTransformation ].

				eachNode withElement: eachChild ])
]

{ #category : #'instance creation' }
BlLayoutParentNode class >> toMeasure: aBlElement [
	^ self new
		constraints: aBlElement constraints;
		children: (
			aBlElement children accountedByLayout collect: [ :eachChild |
				| aTransformation eachNode |
				
				aTransformation := eachChild constraints shouldAccountTransformation
					ifTrue: [ eachChild transformation asElementTransformation. ]
					ifFalse: [ nil ].
				aTransformation := (aTransformation isNil or: [ aTransformation isIdentity ])
					ifTrue: [ nil ]
					ifFalse: [ aTransformation ].
				
				eachNode := BlLayoutChildNode new
					constraints: eachChild constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: eachChild).

				aTransformation
					ifNotNil: [ eachNode := eachNode withTransformation: aTransformation ].

				eachNode withElement: eachChild ])
]

{ #category : #accessing }
BlLayoutParentNode >> children [
	<return: #Collection of: #BlLayoutNode>

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
	
	children := #().
	measuredExtent := 0.0@0.0
]

{ #category : #accessing }
BlLayoutParentNode >> layoutExtent [
	^ layoutExtent
]

{ #category : #accessing }
BlLayoutParentNode >> layoutExtent: anObject [
	layoutExtent := anObject
]

{ #category : #accessing }
BlLayoutParentNode >> measuredExtent [
	<return: #Point>

	^ measuredExtent
]

{ #category : #accessing }
BlLayoutParentNode >> measuredExtent: anObject [
	measuredExtent := anObject
]

{ #category : #accessing }
BlLayoutParentNode >> parent [
	^ self
]

{ #category : #'api - converting' }
BlLayoutParentNode >> withFilter: aSelectBlock [
	^ BlLayoutParentNodeWithFilter new
		parentNode: self;
		filterBlock: aSelectBlock;
		children: (self children select: aSelectBlock)
]
