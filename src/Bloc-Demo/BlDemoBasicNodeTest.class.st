Class {
	#name : #BlDemoBasicNodeTest,
	#superclass : #TestCase,
	#category : #'Bloc-Demo-NodeTests'
}

{ #category : #tests }
BlDemoBasicNodeTest >> testEnsureClassForWithDifferentClass [

	| demo class class2 |
	demo := BlDemoCollector new.
	class := demo ensureClassFor: BlFakeDemo.
	class2 := demo ensureClassFor: BlFakeDemo2.

	self deny: class identicalTo: class2
]

{ #category : #tests }
BlDemoBasicNodeTest >> testEnsureClassForWithSameClass [

	| demo class class2 |
	demo := BlDemoCollector new.
	class := demo ensureClassFor: BlFakeDemo.
	class2 := demo ensureClassFor: BlFakeDemo.

	self assert: class identicalTo: class2
]

{ #category : #tests }
BlDemoBasicNodeTest >> testEnsurePackageForWithSamePackage [

	| demo package package2 |
	demo := BlDemoCollector new.
	package := demo ensurePackageFor: 'Bloc-Demo'.
	package2 := demo ensurePackageFor: 'Bloc-Demo'.

	self assert: package identicalTo: package2
]

{ #category : #tests }
BlDemoBasicNodeTest >> testOneClassWithDifferentPragma [

	| collector elt1 classNode |
	
	collector := BlDemoCollector new.
	collector pragma: #demoTestingPragma2.
	collector collectClass: BlFakeDemo.
	classNode := collector classes first.
	elt1 := classNode children first.
	self assert: elt1 class equals: BlDemoMethodNode.
	
	
]

{ #category : #tests }
BlDemoBasicNodeTest >> testOneClassWithTwoMethodsHasTwoNodes [

	| collector elt1 elt2 classNode |
	collector := BlDemoCollector new.
	collector pragma: #demoTestingPragma.
	collector collectClass: BlFakeDemo.
	classNode := collector classes first.

	elt1 := classNode children first.
	self assert: elt1 class equals: BlDemoMethodNode.

	elt2 := classNode children second.
	self assert: elt2 class equals: BlDemoMethodNode.
	
	
	
]

{ #category : #tests }
BlDemoBasicNodeTest >> testOneClassWithoutPragma [

	| collector |
	collector := BlDemoCollector new.
	collector pragma: #demoTestingPragma_Empty.
	collector collectClass: BlFakeDemo.

	self assert: collector classes isEmpty
]

{ #category : #tests }
BlDemoBasicNodeTest >> testOnePackageWithTwoClassesHasTwoNodes [

	| collector packages |
	collector := BlDemoCollector new.
	collector
		pragma: #demoTestingPragma;
		collectPackageNamed: #'Bloc-Demo'.

	packages := collector packages.
	self assert: packages size equals: 1.
	self assert: packages first class equals: BlDemoPackageNode.
	self assert: packages first children size equals: 2.
	self
		assert: packages first children first class
		equals: BlDemoClassNode
]

{ #category : #tests }
BlDemoBasicNodeTest >> testOnePackageWithTwoClassesHasTwoNodesWithSample2 [

	| collector packages |
	collector := BlDemoCollector new.
	collector
		pragma: #demoTestingPragma2;
		collectPackage:
			(self class packageOrganizer packageNamed: #'Bloc-Demo').

	packages := collector packages.
	self assert: packages size equals: 1.
	self assert: packages first class equals: BlDemoPackageNode.
	self assert: packages first children size equals: 1
]
