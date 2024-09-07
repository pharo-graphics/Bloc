Class {
	#name : #BlLayoutParentNodeWithFilter,
	#superclass : #BlLayoutNonLeafParentNode,
	#instVars : [
		'filter',
		'children'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> children [

	^ children
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> children: aBlLayoutNodeChildren [
	children := aBlLayoutNodeChildren as: BlLayoutNodeChildren.
	children do: [ :eachChild | eachChild parent: self parent ]
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> filterBlock: aBlockClosure [
	filter := aBlockClosure
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> transformationDo: aBlock [
	parentNode transformationDo: aBlock
]

{ #category : #'api - converting' }
BlLayoutParentNodeWithFilter >> withFilter: aSelectBlockOrFilterObject [
	"implement filter as an object to support comparison and not filter twice"

	filter = aSelectBlockOrFilterObject ifTrue: [ ^ self ].

	^ self class new
		  parentNode: self;
		  filterBlock: aSelectBlockOrFilterObject;
		  children: (self children select: aSelectBlockOrFilterObject);
		  yourself
]
