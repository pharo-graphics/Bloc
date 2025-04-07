"
# Layout node with an element
Is used to keep track of the child node and its associated element

"
Class {
	#name : #BlLayoutChildNodeWithElement,
	#superclass : #BlLayoutNonLeafChildNode,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutChildNodeWithElement >> element [

	^ element
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> element: aBlElement [

	element := aBlElement
]

{ #category : #printing }
BlLayoutChildNodeWithElement >> printOn: aStream [

	aStream
		nextPutAll: 'Element position: ';
		print: self element measuredBounds position;
		nextPutAll: ' extent: ';
		print: self element measuredBounds extent
]

{ #category : #converting }
BlLayoutChildNodeWithElement >> withElement: aBlElement [

	^ self
]

{ #category : #converting }
BlLayoutChildNodeWithElement >> withTransformation: aBlElementTransformation [

	^ self class new
		  childNode:
			  (childNode withTransformation: aBlElementTransformation);
		  element: element;
		  yourself
]

{ #category : #converting }
BlLayoutChildNodeWithElement >> withoutElement [

	^ childNode
]

{ #category : #converting }
BlLayoutChildNodeWithElement >> withoutTransformation [

	^ self class new
		  childNode: childNode withoutTransformation;
		  element: element;
		  yourself
]
