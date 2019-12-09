"
I check whether particular ${class:BlEvent}$ events were fired on a ${class:BlElement}$ target.

!! Example

Here you can see how to configure a fire and check a click event on a child element:
${example:BlDevScripterExamples>>#clickCheck|previewExpanded=true|previewHeight=400}$


"
Class {
	#name : #BlDevScripterCheckFiredEventsStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'events'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #asserting }
BlDevScripterCheckFiredEventsStep >> assertEventClass: anEventClass withTarget: aBlElement on: aScripter [ 
	| theInterestingEvents |
	theInterestingEvents := aScripter events select: [ :eachEvent | 
		eachEvent class = anEventClass and: [ eachEvent target = aBlElement ] ].
	self assert: theInterestingEvents size isZero not.
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsStep >> event: aClass [ 
	self events: { aClass }
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsStep >> events [
	<return: #Collection of: #BlEvent>

	^ events
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsStep >> events: aCollection [
	<return: #Collection of: #BlEvent>
	self 
		assert: [ aCollection isCollection and: [ aCollection isNotEmpty ] ]
		description: [ 'Collection of events must be non-empty' ].
	events := aCollection
]

{ #category : #accessing }
BlDevScripterCheckFiredEventsStep >> label [
	^ 'Click Check'
]

{ #category : #actions }
BlDevScripterCheckFiredEventsStep >> playOn: aScripter [
	| anElement |
	self
		assert: [ self events isCollection and: [ self events isNotEmpty ] ]
		description: [ 'Expected events must be defined' ]. 
	anElement := self target findTargetIn: aScripter element.
	self events do: [ :eachEventClass | 
		self assertEventClass: eachEventClass withTarget: anElement on: aScripter ].
]
