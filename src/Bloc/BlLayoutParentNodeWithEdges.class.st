Class {
	#name : #BlLayoutParentNodeWithEdges,
	#superclass : #BlLayoutNonLeafParentNode,
	#instVars : [
		'children'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutParentNodeWithEdges >> children [

	^ children
]

{ #category : #accessing }
BlLayoutParentNodeWithEdges >> children: aBlLayoutNodeChildren [

	children := aBlLayoutNodeChildren as: BlLayoutNodeChildren.
	children do: [ :eachChild | eachChild parent: self parent ]
]

{ #category : #accessing }
BlLayoutParentNodeWithEdges >> transformationDo: aBlock [

	parentNode transformationDo: aBlock
]
