"
A TBlAlignableTest is a test class for testing the behavior of TBlAlignable
"
Class {
	#name : #TBlAlignableTest,
	#superclass : #TestCase,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Tests-Layouts-Alignment'
}

{ #category : #running }
TBlAlignableTest >> setUp [

	super setUp.
	
	element := BlMockAlignableElement new
]

{ #category : #test }
TBlAlignableTest >> testAlignBottomCenter [

	element alignBottomCenter.
	self assert: element isAlignBottomCenter
]

{ #category : #test }
TBlAlignableTest >> testAlignBottomLeft [

	element alignBottomLeft.
	self assert: element isAlignBottomLeft
]

{ #category : #test }
TBlAlignableTest >> testAlignBottomRight [

	element alignBottomRight.
	self assert: element isAlignBottomRight
]

{ #category : #test }
TBlAlignableTest >> testAlignCenter [

	element alignCenter.
	self assert: element isAlignCenter
]

{ #category : #test }
TBlAlignableTest >> testAlignCenterLeft [

	element alignCenterLeft.
	self assert: element isAlignCenterLeft
]

{ #category : #test }
TBlAlignableTest >> testAlignCenterRight [

	element alignCenterRight.
	self assert: element isAlignCenterRight
]

{ #category : #test }
TBlAlignableTest >> testAlignNone [

	element alignNone.
	self assert: element isAlignNone
]

{ #category : #test }
TBlAlignableTest >> testAlignTopCenter [

	element alignTopCenter.
	self assert: element isAlignTopCenter
]

{ #category : #test }
TBlAlignableTest >> testAlignTopLeft [

	element alignTopLeft.
	self assert: element isAlignTopLeft
]

{ #category : #test }
TBlAlignableTest >> testAlignTopRight [

	element alignTopRight.
	self assert: element isAlignTopRight
]
