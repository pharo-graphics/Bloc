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
	#category : #'Bloc-Demo-DemoPresenterNodes'
}

{ #category : #'instance creation' }
BlDemoBasicNode class >> withItem: anObject [

	^ self new
		initializeWithItem: anObject;
		yourself
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
BlDemoBasicNode >> initializeWithItem: anObject [

	self initialize.

	children := OrderedCollection new.

	item := anObject
]

{ #category : #accessing }
BlDemoBasicNode >> item [ 
	^ item
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

{ #category : #printing }
BlDemoBasicNode >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: item;
		nextPutAll: ')'
]
