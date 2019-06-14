Class {
	#name : #BlPulseStatSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'l2',
		'min',
		'max'
	],
	#classVars : [
		'Index',
		'Times'
	],
	#category : #'Bloc-Universe'
}

{ #category : #accessing }
BlPulseStatSignal class >> duration: aDuration [

	Times at: Index put: aDuration asMilliSeconds.
	Index := Index + 1.
	Index <= 60 ifTrue: [ ^self ].
	self new 
		l2: (Times inject: 0 into: [ :s :v | s + (v <= 2 ifTrue: [1] ifFalse: [0]) ]);
		min: Times min;
		max: Times max;
		emit.
	Index := 1.
]

{ #category : #'class initialization' }
BlPulseStatSignal class >> initialize [ 

	Times := Array new: 60.
	Index := 1.
]

{ #category : #accessing }
BlPulseStatSignal >> l2 [
	^ l2
]

{ #category : #accessing }
BlPulseStatSignal >> l2: anObject [
	l2 := anObject
]

{ #category : #accessing }
BlPulseStatSignal >> max [
	^ max
]

{ #category : #accessing }
BlPulseStatSignal >> max: anObject [
	max := anObject
]

{ #category : #accessing }
BlPulseStatSignal >> min [
	^ min
]

{ #category : #accessing }
BlPulseStatSignal >> min: anObject [
	min := anObject
]

{ #category : #printing }
BlPulseStatSignal >> printOneLineContentsOn: stream [

	stream
		<< 'l2: ';
		print: l2;
		<< ', min: ';
		print: min;
		<< ', max: ';
		print: max.
]
