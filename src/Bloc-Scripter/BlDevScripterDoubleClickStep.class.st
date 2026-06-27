Class {
	#name : #BlDevScripterDoubleClickStep,
	#superclass : #BlDevScripterInteractionStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterDoubleClickStep >> defaultLabel [
	^ 'Double Click'
]

{ #category : #actions }
BlDevScripterDoubleClickStep >> playOn: aScripter [
	| targetElement simulator |
	targetElement := self target findTargetStartingInScripter: aScripter.
	simulator := BlEventSimulator forElement: targetElement.
	simulator click.
	simulator click.
	aScripter pulse
]
