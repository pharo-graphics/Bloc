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
		'shouldClose',
		'framesElement',
		'secondsElement',
		'lastFpsElement'
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

	shouldClose ifTrue: [ space close ]
]

{ #category : #initialization }
BlSpaceStatisticsWindow >> createStatisticsElement [

	| insertSeparatorBlock |

	statiticsElement := BlElement new.
	statiticsElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	statiticsElement layout:
		(BlGridLayout horizontal
			 columnCount: 2;
			 cellSpacing: 3;
			 yourself).

	"Separator"
	insertSeparatorBlock := [
		statiticsElement addChildren: { 
			BlElement new
				height: 10;
	 			constraintsDo: [ :c |
					c grid vertical span: 2.
					c grid horizontal span: 2 ];
				yourself } ].

	statiticsElement addChildren: {
		('FPS (Last)' asRopedText asElement).
		(lastFpsElement := 'xxx' asRopedText asElement).
		('FPS (Total)' asRopedText asElement).
		(fpsElement := 'xxx' asRopedText asElement) }.

	insertSeparatorBlock value.

	statiticsElement addChildren: {
		('# Frames' asRopedText asElement).
		(framesElement := 'xxx' asRopedText asElement).
		('# Seconds' asRopedText asElement).
		(secondsElement := 'xxx' asRopedText asElement) }.

	insertSeparatorBlock value.

	"Phases Table Header"			
	statiticsElement addChildren: { 
		'Full GCs' asRopedText asElement.
		(fullGCsElements := 'xxx' asRopedText asElement).
		'Incremental GCs' asRopedText asElement.
		(incrementalGCsElements := 'xxx' asRopedText asElement) }.

	insertSeparatorBlock value.

	"Phases Table Header"			
	statiticsElement addChildren: { 
		'Phase' asRopedText bold asElement.
		'Total Execution Time' asRopedText bold asElement }.
	
	phaseNames := (1 to: 15) collect: [:e | '' asRopedText asElement ].
	phaseTimes := (1 to: phaseNames size) collect: [:e | '' asRopedText asElement ].

	phaseNames with: phaseTimes do: [ :aName :aTime |
		statiticsElement
			addChild: aName;
			addChild: aTime ]
]

{ #category : #private }
BlSpaceStatisticsWindow >> doRefresh [

	| phaseStatistics |
	lastFpsElement text: (self floatToString: statistics fps) asRopedText.
	fpsElement text: (self floatToString: statistics totalFPS) asRopedText.

	framesElement text: statistics totalFrames asRopedText. 
	secondsElement text: (statistics totalMilliseconds / 1000) asInteger asRopedText. 

	fullGCsElements text: self fullGCText.
	incrementalGCsElements text: self incrementalGCText.
	
	phaseStatistics := statistics phaseStatistics.
	phaseNames withIndexDo: [ :nameElement :index |
		| timeElement |
		timeElement := phaseTimes at: index.

		phaseStatistics size >= index 
			ifTrue: [
				| stats |
				stats := phaseStatistics at: index.
				nameElement text: stats first name asRopedText.
				timeElement text: ('{1} [{2} %]' format: {
					stats second.
					(stats third * 100) asInteger }) asRopedText ]
			ifFalse: [
				timeElement text: '' asRopedText.
				nameElement text: '' asRopedText ] ]
]

{ #category : #private }
BlSpaceStatisticsWindow >> floatToString: aNumber [

	^ aNumber printShowingDecimalPlaces: 2
]

{ #category : #actions }
BlSpaceStatisticsWindow >> frameEnded [
]

{ #category : #private }
BlSpaceStatisticsWindow >> fullGCText [

	^ (String streamContents: [ :stream |
		"Delta is normally 0; only show it when non-zero."
		| delta |
		delta := statistics fullGCDuringLastPeriod.
		delta = 0
			ifTrue: [ stream print: statistics fullGCCount ]
			ifFalse: [
				stream
					print: (statistics fullGCCount - delta);
					<< ' +';
					print: delta ] ]) asRopedText
]

{ #category : #private }
BlSpaceStatisticsWindow >> incrementalGCText [

	^ (String streamContents: [ :stream |
		"Delta is normally 0; only show it when non-zero."
		| delta |
		delta := statistics incrementalGCDuringLastPeriod.
		delta = 0
			ifTrue: [ stream print: statistics incrementalGCCount ]
			ifFalse: [
				stream
					print: (statistics incrementalGCCount - delta);
					<< ' +';
					print: delta ] ]) asRopedText
]

{ #category : #private }
BlSpaceStatisticsWindow >> initialExtent [
	
	^ 300 @ 350
]

{ #category : #initialization }
BlSpaceStatisticsWindow >> initializeFor: aBlSpaceStatistics [ 

	statistics := aBlSpaceStatistics.
	statistics registerListener: self.

	space := BlSpace new.
	space extent: self initialExtent.
	space title: 'Statistics'.
	self createStatisticsElement.
	space root addChild: statiticsElement.
	shouldClose := true
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
