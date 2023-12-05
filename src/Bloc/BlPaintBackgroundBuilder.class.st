Class {
	#name : 'BlPaintBackgroundBuilder',
	#superclass : 'BlBackgroundBuilder',
	#instVars : [
		'paint'
	],
	#category : 'Bloc-Basic-Background',
	#package : 'Bloc',
	#tag : 'Basic-Background'
}

{ #category : 'building' }
BlPaintBackgroundBuilder >> build [
	<return: #BlBackground>

	^ (BlPaintBackground paint: self paint) opacity: self opacity
]

{ #category : 'accessing' }
BlPaintBackgroundBuilder >> paint [
	^ paint
]

{ #category : 'accessing' }
BlPaintBackgroundBuilder >> paint: aBlPaint [
	paint := aBlPaint
]
