Class {
	#name : #BlInspectionTest,
	#superclass : #TestCase,
	#instVars : [
		'objectInspector'
	],
	#category : #'Bloc-Spec2-Tests'
}

{ #category : #asserting }
BlInspectionTest >> assertCanSelectPageNamed: aString [

	objectInspector trySelectAnyPageWithName: { aString }.
	self assert: objectInspector selectedPageName equals: aString.

]

{ #category : #running }
BlInspectionTest >> setUp [

	| triangle inspectorWindow |
	super setUp.

	triangle := BlElement new
			size: 120 @ 240;
			border: (BlBorder paint: Color blue width: 5);
			background: Color red;
			yourself.

	inspectorWindow := triangle inspect.
	objectInspector := inspectorWindow presenter firstPage.

]

{ #category : #running }
BlInspectionTest >> tearDown [

	objectInspector withWindowDo: [ :w | w close ].

	super tearDown
]

{ #category : #tests }
BlInspectionTest >> testBlElement [

	self
		assertCanSelectPageNamed: 'Preview';
		assertCanSelectPageNamed: 'Tree';
		assertCanSelectPageNamed: 'User Data';
		assertCanSelectPageNamed: 'Resizers';
		assertCanSelectPageNamed: 'States'
]

{ #category : #tests }
BlInspectionTest >> testBlSpace [

	self assertCanSelectPageNamed: 'Preview'.
	self assertCanSelectPageNamed: 'Tree'.

]
