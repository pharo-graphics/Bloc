Class {
	#name : #FensterPointAPITest,
	#superclass : #TestCase,
	#category : #'Fenster-Tests'
}

{ #category : #tests }
FensterPointAPITest >> testAsLogicalPosition [
	
	| logical |
	logical := (100@300) asLogicalPosition.
	self assert: logical class equals: FensterLogicalPosition.
	self assert: logical y equals: 300.
	self assert: logical x equals: 100.

]

{ #category : #tests }
FensterPointAPITest >> testAsLogicalSize [
	
	| logical |
	logical := (100@300) asLogicalSize.
	self assert: logical class equals: FensterLogicalSize.
	self assert: logical height equals: 300.
	self assert: logical width equals: 100.

]

{ #category : #tests }
FensterPointAPITest >> testAsPhysicalPosition [
	
	| logical |
	logical := (100@300) asPhysicalPosition.
	self assert: logical class equals: FensterPhysicalPosition.
	self assert: logical y equals: 300.
	self assert: logical x equals: 100.

]

{ #category : #tests }
FensterPointAPITest >> testAsPhysicalSize [
	
	| logical |
	logical := (100@300) asPhysicalSize.
	self assert: logical class equals: FensterPhysicalSize.
	self assert: logical height equals: 300.
	self assert: logical width equals: 100.

]
