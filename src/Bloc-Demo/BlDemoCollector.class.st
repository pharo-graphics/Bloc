Class {
	#name : #BlDemoCollector,
	#superclass : #Object,
	#instVars : [
		'dict'
	],
	#category : #'Bloc-Demo-Node'
}

{ #category : #instanceCreation }
BlDemoCollector class >> collectClass: aClass [ 
	^ self new collectClass: aClass.
]

{ #category : #'as yet unclassified' }
BlDemoCollector class >> collectPackage: aPackage [

	^ self new
		  collectPackage: aPackage
]

{ #category : #accessing }
BlDemoCollector >> classes [
	^dict values
]

{ #category : #instanceCreation }
BlDemoCollector >> collectClass: aClass [ 
	
	| node pragmas |
	pragmas := Pragma allNamed: #sampleInstance in: aClass.
	node := BlDemoClassNode new item: aClass.
	pragmas do: [ :pragma | node addChild: (BlDemoMethodNode new item: pragma method ) ].
	^ node
]

{ #category : #'as yet unclassified' }
BlDemoCollector >> collectPackage: aRPackage [

	| classes |
	classes := aRPackage classes do: [ :class |
		           class methods do: [ :method |
			           (method hasPragmaNamed: #sampleInstance) ifTrue: [
				            ((self ensureClassFor: class)
						            addChild: (BlDemoMethodNode new item: method);
						            yourself) ] ] ].
]

{ #category : #'as yet unclassified' }
BlDemoCollector >> ensureClassFor: aClass [

	^ dict at: aClass ifAbsentPut: [BlDemoClassNode new item: aClass; yourself]
]

{ #category : #initialization }
BlDemoCollector >> initialize [ 
	dict := IdentityDictionary new.
]
