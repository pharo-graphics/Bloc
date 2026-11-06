Class {
	#name : #BlHostPulseLoopTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Universe'
}

{ #category : #tests }
BlHostPulseLoopTest >> testAPulseWhichWakesTheLoopUpItselfStaysAtTheRateOfTheLoop [

	| loop evaluations |
	evaluations := 0.
	loop := BlHostPulseLoop new.
	loop hertz: 100.
	loop valuable: [
			evaluations := evaluations + 1.
			loop wakeUp ].
	[
		loop start.
		(Delay forMilliseconds: 300) wait ] ensure: [ loop stop ].
	self assert: evaluations < 50
]

{ #category : #tests }
BlHostPulseLoopTest >> testAnotherProcessCanWakeTheLoopUpBeforeTheNextPulse [

	| loop evaluations |
	evaluations := 0.
	loop := BlHostPulseLoop new.
	loop hertz: 2.
	loop valuable: [ evaluations := evaluations + 1 ].
	[
		loop start.
		(Delay forMilliseconds: 100) wait.
		self assert: evaluations equals: 1.
		loop wakeUp.
		(Delay forMilliseconds: 100) wait.
		self assert: evaluations equals: 2 ] ensure: [ loop stop ]
]
