"
I represent an association of span interval, associated value and validity flag.

I am used by grid layout instead of Dictionary of span <-> value key-value pair for performance reasons. 

Internal Representation and Key Implementation Points.

    Instance Variables
	span:		<Interval>
	valid:		<Boolean>
	value:		<BlMutableInteger>
"
Class {
	#name : #BlGridLayoutArc,
	#superclass : #Object,
	#instVars : [
		'span',
		'value',
		'valid'
	],
	#category : 'Bloc-Layout-Grid-Utilities'
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

{ #category : #'as yet unclassified' }
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
	<return: #Interval>
	^ span
]

{ #category : #accessing }
BlGridLayoutArc >> span: anObject [
	span := anObject
]

{ #category : #accessing }
BlGridLayoutArc >> valid [
	<return: #Boolean>
	^ valid
]

{ #category : #accessing }
BlGridLayoutArc >> valid: anObject [
	valid := anObject
]

{ #category : #accessing }
BlGridLayoutArc >> value [
	<return: #BlGridMutableInteger>
	^ value
]

{ #category : #accessing }
BlGridLayoutArc >> value: anObject [
	value := anObject
]
