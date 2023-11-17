Class {
	#name : #BlDemoBasicNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'class',
		'class2'
	],
	#category : #'Bloc-Demo-NodeTests'
}

{ #category : #tests }
BlDemoBasicNodeTest >> testEnsureClassForWithDifferentClass [

	| demo |
	demo := BlDemoCollector new.
	class := demo ensureClassFor: BlDemoData.
	class2 := demo ensureClassFor: BlDemoData2.
	self deny: class == class2
]

{ #category : #tests }
BlDemoBasicNodeTest >> testEnsureClassForWithSameClass [

	| demo |
	demo := BlDemoCollector new.
	class := demo ensureClassFor: BlDemoData.
	class2 := demo ensureClassFor: BlDemoData.
	self assert: class == class2
]

{ #category : #tests }
BlDemoBasicNodeTest >> testOneClassWithDifferentPragma [

	| collector elt1 classNode |
	
	collector := BlDemoCollector new.
	collector pragma: #sampleInstance2.
	collector collectClass: BlDemoData.
	classNode := collector classes first.
	elt1 := classNode children first.
	self assert: elt1 class equals: BlDemoMethodNode.
	
	
]

{ #category : #tests }
BlDemoBasicNodeTest >> testOneClassWithTwoMethodsHasTwoNodes [

	| collector elt1 elt2 classNode |
	
	collector := BlDemoCollector new.
	collector collectClass: BlDemoData.
	classNode := collector classes first.
	elt1 := classNode children first.
	self assert: elt1 class equals: BlDemoMethodNode.
	elt2 := classNode children second.
	self assert: elt2 class equals: BlDemoMethodNode.
	
	
	
]

{ #category : #tests }
BlDemoBasicNodeTest >> testOneClassWithoutPragma [

	| collector  |
	
	collector := BlDemoCollector new.
	collector pragma: #blabla.
	collector collectClass: BlDemoData.
	self assert: collector classes isEmpty
]

{ #category : #tests }
BlDemoBasicNodeTest >> testOnePackageWithTwoClassesHasTwoNodes [

	| collector classes |
	collector := BlDemoCollector new 
						pragma: #sampleInstance;
						collectPackage:
		             (RPackageOrganizer default packageNamed: #'Bloc-Demo').
	classes := collector classes.
	self assert:  classes size equals: 2.

	self assert: classes first class equals: BlDemoClassNode.
	self assert: classes second class equals: BlDemoClassNode.
	self
		assert: classes first children first class
		equals: BlDemoMethodNode
]

{ #category : #tests }
BlDemoBasicNodeTest >> testOnePackageWithTwoClassesHasTwoNodesWithSample2 [

	| collector classes |
	collector := BlDemoCollector new 
						pragma: #sampleInstance2;
						collectPackage:
		             (RPackageOrganizer default packageNamed: #'Bloc-Demo').
	classes := collector classes.
	self assert:  classes size equals: 1.

	self assert: classes first class equals: BlDemoClassNode.
	self
		assert: classes first children size equals: 1.
		
]
