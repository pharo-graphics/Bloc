"
I define examples with the goal of demonstrating and testing my superclass.

See my references.
"
Class {
	#name : #BlExamplesMock,
	#superclass : #BlExampleTest,
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
BlExamplesMock >> exampleError [

	self error
]

{ #category : #examples }
BlExamplesMock >> exampleFail [

	self fail
]

{ #category : #examples }
BlExamplesMock >> examplePass [
 
	
]

{ #category : #examples }
BlExamplesMock >> exampleSkip [

	<noTest>
	self error
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
