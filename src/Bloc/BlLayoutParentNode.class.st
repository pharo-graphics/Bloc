Class {
	#name : #BlLayoutParentNode,
	#superclass : #BlLayoutNode,
	#traits : 'TBlLayoutNode',
	#classTraits : 'TBlLayoutNode classTrait',
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
						position: 0@0;
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
	children do: [ :eachChild | eachChild parent: self ]
]

{ #category : #enumerating }
BlLayoutParentNode >> childrenDo: aBlock [
	self children do: aBlock
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

{ #category : #'api - enumerating' }
BlLayoutParentNode >> filter: aSelectBlock [
	"Filter my children based on the given block and in-place replace them"
	
	children := children select: aSelectBlock
]

{ #category : #'api - extent spec' }
BlLayoutParentNode >> heightSpec [
	^ extentSpec heightSpec
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

{ #category : #'api - enumerating' }
BlLayoutParentNode >> select: aSelectBlock [
	"Create a new parent node with selected children"
	
	^ self copy children: (children select: aSelectBlock)
]

{ #category : #'api - extent spec' }
BlLayoutParentNode >> widthSpec [
	^ extentSpec widthSpec
]
