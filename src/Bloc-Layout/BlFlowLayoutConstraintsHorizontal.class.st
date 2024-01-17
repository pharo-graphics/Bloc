Class {
	#name : 'BlFlowLayoutConstraintsHorizontal',
	#superclass : 'BlLayoutConstraintsAxis',
	#instVars : [
		'alignment'
	],
	#category : 'Bloc-Layout-Flow',
	#package : 'Bloc-Layout',
	#tag : 'Flow'
}

{ #category : 'alignment' }
BlFlowLayoutConstraintsHorizontal >> alignCenter [
	alignment := BlElementAlignment horizontal center
]

{ #category : 'alignment' }
BlFlowLayoutConstraintsHorizontal >> alignLeft [
	alignment := BlElementAlignment horizontal start
]

{ #category : 'alignment' }
BlFlowLayoutConstraintsHorizontal >> alignRight [
	alignment := BlElementAlignment horizontal end
]

{ #category : 'accessing' }
BlFlowLayoutConstraintsHorizontal >> alignment [
	^ alignment
]

{ #category : 'initialization' }
BlFlowLayoutConstraintsHorizontal >> initialize [
	super initialize.
	
	alignment := BlElementAlignment start horizontal
]
