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

{ #category : #tests }
TBlAlignableTest >> testAlignBottomCenter [

	element alignBottomCenter.
	self assert: element isAlignBottomCenter
]

{ #category : #tests }
TBlAlignableTest >> testAlignBottomLeft [

	element alignBottomLeft.
	self assert: element isAlignBottomLeft
]

{ #category : #tests }
TBlAlignableTest >> testAlignBottomRight [

	element alignBottomRight.
	self assert: element isAlignBottomRight
]

{ #category : #tests }
TBlAlignableTest >> testAlignCenter [

	element alignCenter.
	self assert: element isAlignCenter
]

{ #category : #tests }
TBlAlignableTest >> testAlignCenterLeft [

	element alignCenterLeft.
	self assert: element isAlignCenterLeft
]

{ #category : #tests }
TBlAlignableTest >> testAlignCenterRight [

	element alignCenterRight.
	self assert: element isAlignCenterRight
]

{ #category : #tests }
TBlAlignableTest >> testAlignNone [

	element alignNone.
	self assert: element isAlignNone
]

{ #category : #tests }
TBlAlignableTest >> testAlignTopCenter [

	element alignTopCenter.
	self assert: element isAlignTopCenter
]

{ #category : #tests }
TBlAlignableTest >> testAlignTopLeft [

	element alignTopLeft.
	self assert: element isAlignTopLeft
]

{ #category : #tests }
TBlAlignableTest >> testAlignTopRight [

	element alignTopRight.
	self assert: element isAlignTopRight
]
