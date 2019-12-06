"
I check whether particular ${class:BlEvent}$ events were fired on a ${class:BlElement}$ target.

!! Example

Here you can see how to configure a fire and check a click event on a child element:
${example:BlDevScripterExamples>>#clickCheck|previewExpanded=true|previewHeight=400}$


"
Class {
	#name : #BlDevScripterCheckFiredEventsTask,
	#superclass : #BlDevScripterCheckTask,
	#instVars : [
		'events'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #asserting }
BlDevScripterCheckFiredEventsTask >> assertEventClass: anEventClass withTarget: aBlElement on: aScripter [ 
	| theInterestingEvents |
	theInterestingEvents := aScripter events select: [ :eachEvent | 
		eachEvent class = anEventClass and: [ eachEvent target = aBlElement ] ].
	self assert: theInterestingEvents size isZero not.
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsTask >> event: aClass [ 
	self events: { aClass }
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsTask >> events [
	<return: #Collection of: #BlEvent>

	^ events
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsTask >> events: aCollection [
	<return: #Collection of: #BlEvent>
	self 
		assert: [ aCollection isCollection and: [ aCollection isNotEmpty ] ]
		description: [ 'Collection of events must be non-empty' ].
	events := aCollection
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsTask >> label [
	^ 'Click Check'
]

{ #category : #actions }
BlDevScripterCheckFiredEventsTask >> playOn: aScripter [
	| anElement |
	self
		assert: [ self events isCollection and: [ self events isNotEmpty ] ]
		description: [ 'Expected events must be defined' ]. 
	anElement := self target findTargetIn: aScripter element.
	self events do: [ :eachEventClass | 
		self assertEventClass: eachEventClass withTarget: anElement on: aScripter ].
]
