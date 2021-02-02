Class {
	#name : #BlNewLayoutNodeWithElement,
	#superclass : #Object,
	#type : #variable,
	#traits : 'TBlNewLayoutNodeWithConstraints + TBlNewLayoutCompositeNode + TBlNewLayoutNode',
	#classTraits : 'TBlNewLayoutNodeWithConstraints classTrait + TBlNewLayoutCompositeNode classTrait + TBlNewLayoutNode classTrait',
	#instVars : [
		'node',
		'element'
	],
	#category : #'Bloc-Layouts-Model-New'
}

{ #category : #'as yet unclassified' }
BlNewLayoutNodeWithElement >> children [
	<return: #Collection of: #BlLayoutNode>

	^ self node children
]

{ #category : #'as yet unclassified' }
BlNewLayoutNodeWithElement >> children: aBlLayoutNodeChildren [
	self node children: aBlLayoutNodeChildren
]

{ #category : #accessing }
BlNewLayoutNodeWithElement >> element [
	^ element
]

{ #category : #accessing }
BlNewLayoutNodeWithElement >> element: anObject [
	element := anObject
]

{ #category : #accessing }
BlNewLayoutNodeWithElement >> node [
	^ node
]

{ #category : #accessing }
BlNewLayoutNodeWithElement >> node: anObject [
	node := anObject
]

{ #category : #accessing }
BlNewLayoutNodeWithElement >> parent [
	<return: #BlLayoutParentNode>

	^ self node parent
]

{ #category : #accessing }
BlNewLayoutNodeWithElement >> parent: aBlLayoutParentNode [
	self node parent: aBlLayoutParentNode
]

{ #category : #converting }
BlNewLayoutNodeWithElement >> withElement: anElement [
	^ BlNewLayoutNodeWithElement new
		node: self node;
		element: anElement
]
