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

{ #category : #'instance creation' }
BlDemoCollector class >> collectClass: aClass [

	^ self new collectClass: aClass
]

{ #category : #'instance creation' }
BlDemoCollector class >> collectPackage: aPackage [

	^ self new collectPackage: aPackage
]

{ #category : #'instance creation' }
BlDemoCollector class >> collectPragma: aSymbol fromClass: aClass [

	^ self new
		  pragma: aSymbol;
		  collectClass: aClass 
]

{ #category : #'instance creation' }
BlDemoCollector class >> collectPragma: aSymbol fromPackage: aPackage [

	^ self new 
		pragma: aSymbol; 
		collectPackage: aPackage 
]

{ #category : #accessing }
BlDemoCollector >> classes [
	^ classDictionary values
]

{ #category : #instanceCreation }
BlDemoCollector >> collectClass: aClass [ 
	
	| node pragmas |
	pragmas := (Pragma allNamed: pragma in: aClass) sorted: [ :pragma1 :pragma2 |
		pragma1 methodSelector < pragma2 methodSelector ].
	pragmas ifEmpty: [ ^ self ].
	node := self ensureClassFor: aClass.
	pragmas do: [ :prag | node addChild: (BlDemoMethodNode new item: prag method ) ].
	
	
]

{ #category : #instanceCreation }
BlDemoCollector >> collectPackage: aPackage [

	"| packageClasses packageNode classes |
	packageClasses := (aPackage classes flatCollect: [ :class | { class. class class } ])
		sorted: [ :class1 :class2 | class1 name < class2 name ].
	packageNode := self ensurePackageFor: aPackage.
	classes := OrderedCollection new.
	packageClasses do: [ :pairclass |
		| aNode |
		self collectClass: pairclass.
		aNode := classDictionary at: pairclass ifAbsent: [ nil ].
		aNode ifNotNil: [ packageNode addChild: aNode ] ]."


	| packageClasses node classes |
	packageClasses := (aPackage classes flatCollect: [ :class | { class. class class } ])
		sorted: [ :class1 :class2 | class1 name < class2 name ].
	classes := OrderedCollection new.
	packageClasses do: [ :class |
		| temp |
		self collectClass: class.
		temp := classDictionary at: class ifAbsent: [  ].
		temp ifNotNil: [ classes add: temp ] ].
	classes ifEmpty: [ ^ self ].
	node := self ensurePackageFor: aPackage.
	classes do: [ :classNode | node addChild: classNode ]
	
	
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
		ifAbsentPut: [BlDemoClassNode new item: aClass; yourself]
]

{ #category : #collection }
BlDemoCollector >> ensurePackageFor: aPackage [ 

	^ packageDictionary 
		at: aPackage 
		ifAbsentPut: [ BlDemoPackageNode new item: aPackage; yourself]
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
