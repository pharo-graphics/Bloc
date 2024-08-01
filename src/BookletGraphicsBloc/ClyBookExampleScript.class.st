Class {
	#name : #ClyBookExampleScript,
	#superclass : #ClyClassScript,
	#category : #'BookletGraphicsBloc-Calypso'
}

{ #category : #'script detection' }
ClyBookExampleScript class >> canBeProvidedByMethod: aMethod [
	"This method just checks that method in general can be used for this kind of script"

	^  aMethod numArgs = 0
]

{ #category : #'script detection' }
ClyBookExampleScript class >> isImplementedByMethod: aMethod [
	^ ((aMethod hasPragmaNamed: #bookExample) or: [ (aMethod hasPragmaNamed: #sampleInstance) ]) and: [ (aMethod isTestMethod) not ]
]

{ #category : #accessing }
ClyBookExampleScript >> description [
	^ 'Run the book example'
]

{ #category : #execution }
ClyBookExampleScript >> executeOn: aClass [

	| exampleResult |
	exampleResult := aClass instanceSide new perform:
		                 implementorMethod selector.

	"exampleResult class = BlElement
		ifTrue: [ exampleResult openInNewSpace ]
		ifFalse: [ exampleResult inspect ]."
	exampleResult inspect.
	^ exampleResult
]

{ #category : #accessing }
ClyBookExampleScript >> iconName [
	^#smallLanguage
]
