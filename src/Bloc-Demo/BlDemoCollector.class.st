Class {
	#name : #BlDemoCollector,
	#superclass : #Object,
	#instVars : [
		'dict',
		'pragma'
	],
	#category : #'Bloc-Demo-Node'
}

{ #category : #'instance creation' }
BlDemoCollector class >> collectClass: aClass [ 
	^ self new collectClass: aClass.
]

{ #category : #'instance creation' }
BlDemoCollector class >> collectPackage: aPackage [

	^ self new collectPackage: aPackage
]

{ #category : #'as yet unclassified' }
BlDemoCollector class >> collectPragma: aSymbol fromClass: aClass [

	^ self new
		  pragma: aSymbol;
		  collectClass: aClass 
]

{ #category : #'as yet unclassified' }
BlDemoCollector class >> collectPragma: aSymbol fromPackage: aPackage [ 
	^ self new pragma: aSymbol; collectPackage: aPackage 
]

{ #category : #accessing }
BlDemoCollector >> classes [
	^dict values
]

{ #category : #instanceCreation }
BlDemoCollector >> collectClass: aClass [ 
	
	| node pragmas |
	pragmas := Pragma allNamed: pragma in: aClass.
	pragmas ifEmpty: [ ^ self ].
	node := self ensureClassFor: aClass.
	pragmas do: [ :prag | node addChild: (BlDemoMethodNode new item: prag method ) ].
	
	
]

{ #category : #'as yet unclassified' }
BlDemoCollector >> collectPackage: aRPackage [ 
	
	aRPackage classes do: [ :each | self collectClass: each ]
]

{ #category : #'as yet unclassified' }
BlDemoCollector >> ensureClassFor: aClass [

	^ dict at: aClass ifAbsentPut: [BlDemoClassNode new item: aClass; yourself]
]

{ #category : #initialization }
BlDemoCollector >> initialize [
	super initialize.
	pragma := #sampleInstance.
	dict := IdentityDictionary new.
]

{ #category : #accessing }
BlDemoCollector >> pragma: aString [ 
	pragma := aString
]
