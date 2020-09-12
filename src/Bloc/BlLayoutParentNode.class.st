Class {
	#name : #BlLayoutParentNode,
	#superclass : #BlLayoutNode,
	#instVars : [
		'children',
		'extentSpec',
		'measuredExtent',
		'layoutExtent'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #'instance creation' }
BlLayoutParentNode class >> toMeasure: aBlElement [
	^ self new
		constraints: aBlElement constraints;
		children: (
			aBlElement children accountedByLayout collect: [ :eachChild |
				| aTransformation |
				
				aTransformation := eachChild constraints shouldAccountTransformation
					ifTrue: [ eachChild transformation asElementTransformation. ]
					ifFalse: [ nil ].
				aTransformation := (aTransformation isNil or: [ aTransformation isIdentity ])
					ifTrue: [ nil ]
					ifFalse: [ aTransformation ].
				
				BlLayoutChildNode new
					constraints: eachChild constraints;
					measurement: (BlLayoutNodeElementMeasurement new element: eachChild);
					transformation: aTransformation ])
]

{ #category : #accessing }
BlLayoutParentNode >> children [
	<return: #Collection of: #BlLayoutNode>

	^ children
]

{ #category : #accessing }
BlLayoutParentNode >> children: aCollectionOfChildNodes [
	children := aCollectionOfChildNodes.
	children do: [ :eachChild | eachChild parent: self ]
]

{ #category : #enumerating }
BlLayoutParentNode >> childrenDo: aBlock [
	self children do: aBlock
]

{ #category : #'api - extent spec' }
BlLayoutParentNode >> extentSpec [
	^ extentSpec
]

{ #category : #accessing }
BlLayoutParentNode >> extentSpec: anObject [
	extentSpec := anObject
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

{ #category : #'api - extent spec' }
BlLayoutParentNode >> widthSpec [
	^ extentSpec widthSpec
]
