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
	^ (aMethod hasPragmaNamed: #gtExample)
]

{ #category : #accessing }
ClyGtExampleScript >> description [
	^ 'Run the gtexample'
]

{ #category : #accessing }
ClyGtExampleScript >> executeOn: aClass [
	"Execute the corresponding method of the argument."
	
	| res |
	res := aClass instanceSide new  perform: implementorMethod selector.
	res inspect.
	^ res
]

{ #category : #accessing }
ClyGtExampleScript >> iconName [
	^#smallDoItIcon
]
