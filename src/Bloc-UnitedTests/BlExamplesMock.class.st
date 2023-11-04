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
	#package : 'Bloc',
	#tag : 'UnitedTests-Examples'
}

{ #category : #accessing }
BlExamplesMock >> enableRunning [

	enabled := true
]

{ #category : #examples }
BlExamplesMock >> exampleError [
	<sampleInstance>

	self error
]

{ #category : #examples }
BlExamplesMock >> exampleFail [
	<sampleInstance>

	self fail
]

{ #category : #examples }
BlExamplesMock >> examplePass [
	<sampleInstance>

]

{ #category : #examples }
BlExamplesMock >> exampleSkip [
	<sampleInstance>
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
