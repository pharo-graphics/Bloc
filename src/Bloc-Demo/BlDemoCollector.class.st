"
I'm responsible of collecting demo nodes from a given pragma.
"
Class {
	#name : #BlDemoCollector,
	#superclass : #Object,
	#instVars : [
		'pragma',
		'packageDictionary',
		'classDictionary'
	],
	#category : #'Bloc-Demo-DemoPresenterNodes'
}

{ #category : #accessing }
BlDemoCollector >> classes [

	^ classDictionary values
]

{ #category : #instanceCreation }
BlDemoCollector >> collectClass: aClass [ 
	
	| node pragmas |
	pragmas := (Pragma allNamed: pragma in: aClass)
		sorted: [ :pragma1 :pragma2 |
			pragma1 methodSelector < pragma2 methodSelector ].

	pragmas ifEmpty: [ ^ self ].
	node := self ensureClassFor: aClass.
	pragmas do: [ :each |
		node addChild: (BlDemoMethodNode withItem: each method) ]
]

{ #category : #instanceCreation }
BlDemoCollector >> collectPackage: aPackage [

	| packageClasses node classes |
	packageClasses := (aPackage definedClasses
		flatCollect: [ :class | { class. class class } ])
		sorted: [ :class1 :class2 | class1 name < class2 name ].
	classes := OrderedCollection new.
	packageClasses do: [ :class |
		self collectClass: class.
		classDictionary at: class ifPresent: [ :c | classes add: c ] ].
	classes ifEmpty: [ ^ self ].
	node := self ensurePackageFor: aPackage.
	classes do: [ :classNode | node addChild: classNode ]
	
	
]

{ #category : #'as yet unclassified' }
BlDemoCollector >> collectPackageNamed: aString [

	self collectPackage: (self class packageOrganizer packageNamed: aString)
]

{ #category : #collection }
BlDemoCollector >> collectPackages: anOrderedCollection [

	(anOrderedCollection sorted: [ :p1 :p2 | p1 name < p2 name ])
		do: [ :each | self collectPackage: each ]
]

{ #category : #collection }
BlDemoCollector >> ensureClassFor: aClass [

	^ classDictionary 
		at: aClass 
		ifAbsentPut: [ BlDemoClassNode withItem: aClass ]
]

{ #category : #collection }
BlDemoCollector >> ensurePackageFor: aPackage [ 

	^ packageDictionary 
		at: aPackage 
		ifAbsentPut: [ BlDemoPackageNode withItem: aPackage ]
]

{ #category : #initialization }
BlDemoCollector >> initialize [

	super initialize.
	pragma := #demo.
	packageDictionary := OrderedIdentityDictionary new.
	classDictionary := IdentityDictionary new
]

{ #category : #accessing }
BlDemoCollector >> packages [

	^ packageDictionary values
]

{ #category : #accessing }
BlDemoCollector >> pragma: aString [

	pragma := aString
]
