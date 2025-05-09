"
Is sent as soon as animation loop is done (loop progress >= 1)

"
Class {
	#name : #BlAnimationLoopDoneAnnouncement,
	#superclass : #BlAnimationAnnouncement,
	#instVars : [
		'loopCount'
	],
	#category : #'Bloc-Animation-Events'
}

{ #category : #accessing }
BlAnimationLoopDoneAnnouncement >> loopCount [

	^ loopCount
]

{ #category : #accessing }
BlAnimationLoopDoneAnnouncement >> loopCount: anInteger [

	loopCount := anInteger
]
