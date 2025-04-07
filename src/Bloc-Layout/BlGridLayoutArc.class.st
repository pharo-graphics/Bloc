"
I represent an association of span interval, associated value and validity flag.

I am used by grid layout instead of Dictionary of span <-> value key-value pair for performance reasons. 

Internal Representation and Key Implementation Points.

Instance Variables
	span:		<BlGridLayoutInterval>
	valid:		<Boolean>
	value:		<BlGridMutableInteger>

"
Class {
	#name : #BlGridLayoutArc,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'span',
		'value',
		'valid'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #'instance creation' }
BlGridLayoutArc class >> span: span value: value [
	^ self new
		span: span;
		value: value
]

{ #category : #initialization }
BlGridLayoutArc >> initialize [
	super initialize.
	
	valid := true
]

{ #category : #printing }
BlGridLayoutArc >> printOn: aStream [
	aStream
		nextPutAll: self span asString;
		nextPutAll: ' -> ';
		nextPutAll: self value asString;
		nextPutAll: ' : ';
		nextPutAll: self valid asString
]

{ #category : #accessing }
BlGridLayoutArc >> span [
	<return: #BlGridLayoutInterval>

	^ span
]

{ #category : #accessing }
BlGridLayoutArc >> span: aBlGridLayoutInterval [
	"Debugging internal implementation"
	self
		assert: [ aBlGridLayoutInterval isKindOf: BlGridLayoutInterval ]
		description: [ 'Span must be a special type of Interval' ].

	span := aBlGridLayoutInterval
]

{ #category : #accessing }
BlGridLayoutArc >> valid [
	<return: #Boolean>

	^ valid
]

{ #category : #accessing }
BlGridLayoutArc >> valid: aBoolean [
	valid := aBoolean
]

{ #category : #evaluating }
BlGridLayoutArc >> value [
	<return: #BlGridMutableInteger>

	^ value
]

{ #category : #accessing }
BlGridLayoutArc >> value: aBlGridMutableInteger [
	value := aBlGridMutableInteger
]
