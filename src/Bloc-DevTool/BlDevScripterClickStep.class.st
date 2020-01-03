"
I fire a ${class:BlMouseDownEvent}$, ${class:BlMouseUpEvent}$, and ${class:BlClickEvent}$.

!! Example

Here you can see how to configure a fire and check a click event on a child element:
${example:BlDevScripterExamples>>#clickCheck|previewExpanded=true|previewHeight=400}$


"
Class {
	#name : #BlDevScripterClickStep,
	#superclass : #BlDevScripterInteractionStep,
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterClickStep >> defaultLabel [
	^ 'Click'
]

{ #category : #actions }
BlDevScripterClickStep >> omitDoubleClickOn: aScripter [
	| anEvent aDuration |
	anEvent := aScripter events detect: [ :eachEvent | eachEvent class = BlClickEvent ] ifNone: [ ^ self ].
	aDuration := BlMouseProcessor dblClickDelay - (aScripter time now - anEvent timestamp).
	aDuration < 0 seconds ifTrue: [ ^ self ]. 
	aScripter time wait: aDuration.
]

{ #category : #actions }
BlDevScripterClickStep >> playOn: aScripter [
	self omitDoubleClickOn: aScripter.
	BlSpace simulateClickOn: (self target findTargetStartingInScripter: aScripter).
	aScripter pulse
]
