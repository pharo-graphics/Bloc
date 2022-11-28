Class {
	#name : #ClyGtExampleScript,
	#superclass : #ClyClassScript,
	#category : #'Bloc-PharoExtensions'
}

{ #category : #'script detection' }
ClyGtExampleScript class >> canBeProvidedByMethod: aMethod [
	"This method just checks that method in general can be used for this kind of script"

	^  aMethod numArgs = 0
]

{ #category : #'script detection' }
ClyGtExampleScript class >> isImplementedByMethod: aMethod [
	^ (aMethod hasPragmaNamed: #gtExample) and: [ (aMethod isTestMethod) not ]
]

{ #category : #accessing }
ClyGtExampleScript >> description [
	^ 'Run the gtExample'
]

{ #category : #accessing }
ClyGtExampleScript >> executeOn: aClass [

	| exampleResult |
	exampleResult := aClass instanceSide new perform: implementorMethod selector.

	exampleResult class = BlElement
		ifTrue: [ exampleResult openInNewSpace ]
		ifFalse: [ exampleResult inspect ].

	^ exampleResult
]

{ #category : #accessing }
ClyGtExampleScript >> iconName [
	^#smallDoItIcon
]
