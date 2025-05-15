"
I open an small window with the statistics of BlSpaceStatistics
"
Class {
	#name : #BlSpaceStatisticsWindow,
	#superclass : #Object,
	#instVars : [
		'space',
		'statiticsElement',
		'statistics',
		'fpsElement',
		'fullGCsElements',
		'incrementalGCsElements',
		'phaseTimes',
		'phaseNames',
		'shouldClose'
	],
	#category : #'Bloc-DevTool-Profiling'
}

{ #category : #'instance creation' }
BlSpaceStatisticsWindow class >> for: aBlSpace [

	aBlSpace enableStatistics.

	^ self basicNew
		  initializeFor: aBlSpace spaceStatistics;
		  yourself
]

{ #category : #actions }
BlSpaceStatisticsWindow >> closed [

	shouldClose ifTrue: [space close]
]

{ #category : #initialization }
BlSpaceStatisticsWindow >> createStatisticsElement [

	statiticsElement := BlElement new.
	statiticsElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	statiticsElement layout: (BlGridLayout horizontal
			 columnCount: 2;
			 cellSpacing: 3;
			 yourself).

	statiticsElement addChildren: {
			('FPS' asRopedText asElement
				 width: 100;
				 yourself).
			(fpsElement := 'xxx' asRopedText asElement).
			'FullGCs' asRopedText asElement.
			(fullGCsElements := 'xxx' asRopedText asElement).
			'IncrementalGCs' asRopedText asElement.
			(incrementalGCsElements := 'xxx' asRopedText asElement) }.
			
	statiticsElement addChildren: { 
		BlElement new height: 10; yourself.
		BlElement new height: 10; yourself.
		'Phase' asRopedText bold asElement.
		'Time' asRopedText bold asElement.
	 }.
	
	phaseNames := (1 to: 15) collect: [:e | '' asRopedText asElement ].
	phaseTimes := (1 to: phaseNames size) collect: [:e | '' asRopedText asElement ].

	phaseNames with: phaseTimes do: [ :aName :aTime | statiticsElement addChild: aName; addChild: aTime ]
]

{ #category : #actions }
BlSpaceStatisticsWindow >> doRefresh [

	| phaseStats |

	fpsElement text: (statistics fps printString , ' / ' , statistics fullFPS printString) asRopedText. 
	fullGCsElements text: (statistics fullGCDuringLastPeriod printString , ' / ' , statistics fullGCCount printString) asRopedText. 
	incrementalGCsElements text: (statistics incrementalGCDuringLastPeriod printString , ' / ' , statistics incrementalGCCount printString) asRopedText.
	
	phaseStats := statistics phaseStatistics.
	
	phaseNames withIndexDo: [ :nameElement :index | |timeElement stats|
		timeElement := phaseTimes at: index.
		phaseStats size >= index 
			ifTrue: [ 
				stats := phaseStats at: index.
				nameElement text: stats first name asRopedText .
				timeElement text: ('{1} / {2} %' format: { stats second. (stats third * 100) roundTo: 0.01 }) asRopedText]
			ifFalse: [ timeElement text: '' asRopedText. nameElement text: '' asRopedText ]]
]

{ #category : #'as yet unclassified' }
BlSpaceStatisticsWindow >> frameEnded [
]

{ #category : #initialization }
BlSpaceStatisticsWindow >> initializeFor: aPRSpaceStatistics [ 

	statistics := aPRSpaceStatistics.
	statistics registerListener: self.
	
	space := BlSpace new.
	self createStatisticsElement.
	space root addChild: statiticsElement.
	shouldClose := true.
]

{ #category : #actions }
BlSpaceStatisticsWindow >> keepOpened [

	shouldClose := false
]

{ #category : #actions }
BlSpaceStatisticsWindow >> open [
	
	space show
]

{ #category : #actions }
BlSpaceStatisticsWindow >> refresh [

	space universe defer: [ self doRefresh ]
]
