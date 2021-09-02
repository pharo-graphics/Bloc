"
I fire a {{gtClass:BlMouseDownEvent}}, {{gtClass:BlMouseUpEvent}}, and {{gtClass:BlClickEvent}}.

## Example

Here you can see how to configure a fire and check a click event on a child element:
{{gtExample:BlDevScripterExamples>>#clickCheck|previewExpanded=true|previewHeight=400}}


"
Class {
	#name : 'BlDevScripterClickStep',
	#superclass : 'BlDevScripterInteractionStep',
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : 'accessing' }
BlDevScripterClickStep >> defaultLabel [
	^ 'Click'
]

{ #category : 'actions' }
BlDevScripterClickStep >> omitDoubleClickOn: aScripter [
	| anEvent aDuration |

	anEvent := aScripter events reversed
		detectEventOfClass: BlClickEvent
		ifNone: [ ^ self ].
	
	"wait twice as long as double click delay to prevent `random` double click detections"
	aDuration := (BlMouseProcessor dblClickDelay * 2) - (aScripter time now - anEvent timestamp).
	aDuration < 0 seconds
		ifTrue: [ ^ self ].
	aScripter time wait: aDuration
]

{ #category : 'actions' }
BlDevScripterClickStep >> playOn: aScripter [
	self omitDoubleClickOn: aScripter.
	self
		setMousePosition: (BlSpace simulateClickOn: (self target findTargetStartingInScripter: aScripter))
		in: aScripter.

	aScripter pulse
]
