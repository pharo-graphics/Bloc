"
I define examples with the goal of demonstrating and testing my superclass.

See my references.
"
Class {
	#name : #BlExamplesMock,
	#superclass : #BlExamplesTest,
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
	<gtExample>

	self error
]

{ #category : #examples }
BlExamplesMock >> exampleFail [
	<gtExample>

	self fail
]

{ #category : #examples }
BlExamplesMock >> examplePass [
	<gtExample>

]

{ #category : #examples }
BlExamplesMock >> exampleSkip [
	<gtExample>
	<noTest>
	
	self error
]

{ #category : #examples }
BlExamplesMock >> exampleWithArgument: arg [
	<gtExample>
	
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
