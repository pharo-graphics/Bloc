"
A BlIntervalCollectorTest is a test class for testing the behavior of BlIntervalCollector
"
Class {
	#name : 'BlIntervalCollectorTest',
	#superclass : 'TestCase',
	#instVars : [
		'collector'
	],
	#category : 'Bloc-Text-Tests-Text-Operator',
	#package : 'Bloc-Text-Tests',
	#tag : 'Text-Operator'
}

{ #category : 'initialization' }
BlIntervalCollectorTest >> setUp [
	super setUp.
	collector := BlIntervalCollector new
	
]

{ #category : 'initialization' }
BlIntervalCollectorTest >> testWithNoText [
	self assert: (collector searchAll:'AA') isEmpty
]

{ #category : 'initialization' }
BlIntervalCollectorTest >> testWithTextNoSubstring [
	collector text: 'XXXXXXXXX'.
	self assert: (collector searchAll: 'AA') isEmpty
]

{ #category : 'initialization' }
BlIntervalCollectorTest >> testWithTextOneSubstringAt_1 [
	| result |
	collector text: 'AAXXXXXXX'.
	result := collector searchAll: 'AA'.
	self assert: result	size equals: 1.
	self assert: result first first equals: 1.
	self assert: result first last equals: 2. 	
]

{ #category : 'initialization' }
BlIntervalCollectorTest >> testWithTextOneSubstring_1 [
	| result |
	collector text: 'AAAAAA'.
	result := collector searchAll:'AA'.
	self assert: result	size equals: 3.
	self assert: result first first equals: 1.
	self assert: result first last equals: 2. 		
	self assert: result second first equals: 3.
	self assert: result second last equals: 4. 
	self assert: result third first equals: 5.
	self assert: result third last equals: 6
]

{ #category : 'initialization' }
BlIntervalCollectorTest >> testWithTextOneSubstring_2 [
	| result |
	collector text: 'AA AA AA A'.
	result := collector searchAll: 'AA'.
	self assert: result	size equals: 3.
	self assert: result first first equals: 1.
	self assert: result first last equals: 2. 		
	self assert: result second first equals: 4.
	self assert: result second last equals: 5. 
	self assert: result third first equals: 7.
	self assert: result third last equals: 8
]

{ #category : 'initialization' }
BlIntervalCollectorTest >> testWithTextOneSubstring_3 [
	| result |
	collector text: ' AA AA AA A'.
	result := collector searchAll: 'AA AA AA A'.
	self assert: result	size equals: 1.
	self assert: result first first equals: 2.
	self assert: result first last equals: 11. 		

]

{ #category : 'initialization' }
BlIntervalCollectorTest >> testWithTextOneSubstring_4 [
	| result |
	collector text: ')))'.
	result := collector searchAll: '))'.
	self assert: result	size equals: 1.
	self assert: result first first equals: 1.
	self assert: result first last equals: 2. 		

]
