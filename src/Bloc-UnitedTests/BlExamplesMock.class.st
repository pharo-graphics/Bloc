"
I define examples with the goal of demonstrating and testing my superclass.

See my references.
"
Class {
	#name : #BlExamplesMock,
	#superclass : #TestCase,
	#instVars : [
		'enabled'
	],
	#category : #'Bloc-UnitedTests-Examples'
}

{ #category : #accessing }
BlExamplesMock >> enableRunning [

	enabled := true
]

{ #category : #examples }
BlExamplesMock >> exampleWithArgument: arg [

	
]

{ #category : #initialization }
BlExamplesMock >> initialize [

	super initialize.
	enabled := false
]

{ #category : #private }
BlExamplesMock >> performTest [

	enabled ifTrue: [ super performTest ]
]

{ #category : #examples }
BlExamplesMock >> testExampleError [

	self error
]

{ #category : #examples }
BlExamplesMock >> testExampleFail [

	self fail
]

{ #category : #examples }
BlExamplesMock >> testExamplePass [
 
	
]

{ #category : #examples }
BlExamplesMock >> testExampleSkip [

	self skip
]
