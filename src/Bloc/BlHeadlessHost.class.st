"
I am a fallback host that is chosen if there are no other available and supported hosts.
"
Class {
	#name : #BlHeadlessHost,
	#superclass : #BlHost,
	#instVars : [
		'isRunning'
	],
	#category : 'Bloc-Universe'
}

{ #category : #'driver selection' }
BlHeadlessHost class >> label [
	^ 'Null'
]

{ #category : #'driver selection' }
BlHeadlessHost class >> priority [
	"Infinite priority means that I am selected only if there are no other available hosts"
	<return: #Number>
	
	^ Float infinity
]

{ #category : #api }
BlHeadlessHost >> createHostSpaceFor: aSpace [

	aSpace hostSpace: (BlHeadlessHostSpace new host: self; space: aSpace)
]

{ #category : #api }
BlHeadlessHost >> destroyHostSpaceFor: aSpace [
	aSpace detachHostSpace
]

{ #category : #initialization }
BlHeadlessHost >> initialize [
	super initialize.
	
	isRunning := false
]

{ #category : #api }
BlHeadlessHost >> isRunning [
	^ isRunning
]

{ #category : #api }
BlHeadlessHost >> start [
	isRunning := true
]

{ #category : #api }
BlHeadlessHost >> stop [
	isRunning := false
]
