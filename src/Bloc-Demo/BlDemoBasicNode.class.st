"
I'm the head of a little domain to represent classes, methods, and package for the demo collector tool (a tool to browse demo expressed as methods).
"
Class {
	#name : #BlDemoBasicNode,
	#superclass : #Object,
	#instVars : [
		'item',
		'parent',
		'children'
	],
	#category : #'Bloc-Demo-Node'
}

{ #category : #'as yet unclassified' }
BlDemoBasicNode class >> withItem: anObject [

	^ self new item: anObject 
	
]

{ #category : #adding }
BlDemoBasicNode >> addChild: aNode [ 
	
	self children add: aNode
]

{ #category : #accessing }
BlDemoBasicNode >> children [ 
	^ children
]

{ #category : #accessing }
BlDemoBasicNode >> children: anOrderedCollection [

	children :=anOrderedCollection 
]

{ #category : #initialization }
BlDemoBasicNode >> initialize [

	super initialize.
	children := OrderedCollection new
]

{ #category : #accessing }
BlDemoBasicNode >> item [ 
	^ item
]

{ #category : #accessing }
BlDemoBasicNode >> item: anObject [

	item := anObject 
]

{ #category : #accessing }
BlDemoBasicNode >> name [ 
	^ item name
]

{ #category : #accessing }
BlDemoBasicNode >> parent [ 
	^ parent
]

{ #category : #accessing }
BlDemoBasicNode >> parent: aNode [

	parent := aNode 
]
