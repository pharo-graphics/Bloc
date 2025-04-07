Class {
	#name : #BlGridLayoutConstraintsAxis,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'spec'
	],
	#category : #'Bloc-Layout-Grid'
}

{ #category : #alignment }
BlGridLayoutConstraintsAxis >> alignCenter [
	self subclassResponsibility
]

{ #category : #initialization }
BlGridLayoutConstraintsAxis >> defaultSpec [
	<return: #BlGridLayoutSpec>

	^ BlGridLayoutSpec undefined
]

{ #category : #initialization }
BlGridLayoutConstraintsAxis >> initialize [
	super initialize.
	
	spec := self defaultSpec
]

{ #category : #accessing }
BlGridLayoutConstraintsAxis >> span: aNumber [
	"Change how many cells (rows or columns) an element needs to take.
	if span is set to 0 grid will ignore space needs of that element
	which may result in overlapping with neighbor rows or columns.
	aNumber must be greater or equal to 0
	aNumber must not be nil"

	self specSpan: (BlGridLayoutInterval
			 min: self spec span min
			 max: self spec span min + aNumber)
]

{ #category : #private }
BlGridLayoutConstraintsAxis >> spec [
	"Return child's axis specification.
	spec can not be nil"
	<return: #BlGridLayoutSpec>

	^ spec
]

{ #category : #private }
BlGridLayoutConstraintsAxis >> specAlignment: anAlignment [
	spec := self spec copyWithAlignment: anAlignment
]

{ #category : #private }
BlGridLayoutConstraintsAxis >> specSpan: aBlGridlLayoutInterval [

	spec := spec copyWithSpan: aBlGridlLayoutInterval
]

{ #category : #accessing }
BlGridLayoutConstraintsAxis >> weight: aNumber [
	"Set cell's weight along corresponding axis. Only positive
	weight (> 0) is taken into account. In order reset/disable
	flexible cell distribution set weight to 0.
	aNumber must be equal or greater than 0"
	self assert: aNumber isNotNil.
	self assert: aNumber >= 0.

	spec := self spec copyWithWeight: aNumber asFloat
]
