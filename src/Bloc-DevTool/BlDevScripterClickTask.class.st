"
I fire a ${class:BlMouseDownEvent}$, ${class:BlMouseUpEvent}$, and ${class:BlClickEvent}$.

!! Example

Here you can see how to configure a fire and check a click event on a child element:
${example:BlDevScripterExamples>>#clickCheck|previewExpanded=true|previewHeight=400}$


"
Class {
	#name : #BlDevScripterClickTask,
	#superclass : #BlDevScripterInteractionTask,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterClickTask >> label [
	^ 'Click'
]

{ #category : #actions }
BlDevScripterClickTask >> playOn: aScripter [
	BlSpace simulateClickOn: (self target findTargetIn: aScripter element).
	aScripter pulse
]
