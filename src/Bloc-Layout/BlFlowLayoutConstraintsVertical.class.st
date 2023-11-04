Class {
	#name : #BlFlowLayoutConstraintsVertical,
	#superclass : #BlLayoutConstraintsAxis,
	#instVars : [
		'alignment'
	],
	#package : 'Bloc',
	#tag : 'Layout-Flow'
}

{ #category : #alignment }
BlFlowLayoutConstraintsVertical >> alignBottom [
	alignment := BlElementAlignment vertical end
]

{ #category : #alignment }
BlFlowLayoutConstraintsVertical >> alignCenter [
	alignment := BlElementAlignment vertical center
]

{ #category : #alignment }
BlFlowLayoutConstraintsVertical >> alignTop [
	alignment := BlElementAlignment vertical start
]

{ #category : #accessing }
BlFlowLayoutConstraintsVertical >> alignment [
	^ alignment
]

{ #category : #initialization }
BlFlowLayoutConstraintsVertical >> initialize [
	super initialize.
	
	alignment := BlElementAlignment start vertical
]
