"
I represent the main loop of a host class, that sends it #pulse regularly.

My loop follows the next rules:
- The #pulsePeriod duration is the minimum amount of time between two subsequent sends of #pulse.
- If a pulse took more time than #pulsePeriod, then the next pulse may either send the next #pulse immediately, or do a small wait before if another process with lower priority is suspended (and may be starving).

The opened spaces listen the pulse to be synchronized and to update their state when it is needed.

"
Class {
	#name : #BlHostPulseLoop,
	#superclass : #Object,
	#instVars : [
		'hostClass',
		'loopProcess',
		'pulsePeriodMS',
		'msToWaitForBackgroundProcess',
		'pulseStartMS',
		'pulseDurationMS'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'instance creation' }
BlHostPulseLoop class >> forHost: aHostClass [

	^ self basicNew
		  initialize;
		  hostClass: aHostClass;
		  yourself
]

{ #category : #'instance creation' }
BlHostPulseLoop class >> new [

	self error: 'Use #forHost: instead'
]

{ #category : #accessing }
BlHostPulseLoop class >> processId [

	^ 'Bloc Main Loop'
]

{ #category : #period }
BlHostPulseLoop >> defaultPulsePeriod [

	^ 15 milliSeconds
]

{ #category : #debug }
BlHostPulseLoop >> forceStartNewUIProcess [
	"I should only be used by the logic for opening the debugger.
	
	I create and start a new UI thread without stopping the previous one.
	Normally this leads to incorrect behaviou in Bloc UI process. However 
	if I am called from the current Bloc UI process when an error happened in 
	the actual process, and after calling me my sender terminates or suspends 
	the process my usage should be safe."
	
	loopProcess := self newLoopProcess.
	loopProcess resume.
]

{ #category : #debug }
BlHostPulseLoop >> forceStartOfUIProcess: aProces [
	"I should only be used by the logic for closing the debugger."
	
	loopProcess := aProces.
	loopProcess resume.
]

{ #category : #accessing }
BlHostPulseLoop >> hostClass [

	^ hostClass
]

{ #category : #accessing }
BlHostPulseLoop >> hostClass: aHostClass [

	hostClass := aHostClass
]

{ #category : #initialization }
BlHostPulseLoop >> initialize [

	super initialize.

	self pulsePeriod: self defaultPulsePeriod
]

{ #category : #testing }
BlHostPulseLoop >> isRunning [

	^ loopProcess isNotNil and: [ loopProcess isTerminated not ]
]

{ #category : #testing }
BlHostPulseLoop >> isRunningInTheSameProcess [

	^ Processor activeProcess effectiveProcess == loopProcess
]

{ #category : #'loop process' }
BlHostPulseLoop >> loop [

	[ self loopIteration ] whileTrue
]

{ #category : #'loop process' }
BlHostPulseLoop >> loopIteration [

	| universe |

	[
		pulseStartMS := Time millisecondClockValue.
		universe := hostClass universe.
		universe pulse.
		pulseDurationMS := Time millisecondClockValue - pulseStartMS.
		self waitUntilNextPulse. ]
	on: Exception
	do: [ :e |
		self forceStartNewUIProcess.
		e pass ].

	"Returns true to continue looping"
	^ self isRunningInTheSameProcess 
]

{ #category : #accessing }
BlHostPulseLoop >> loopProcess [

	^ loopProcess
]

{ #category : #'loop process' }
BlHostPulseLoop >> newLoopProcess [

	^ [ self loop ] newProcess
		  priority: self processPriority;
		  name: self processId;
		  yourself
]

{ #category : #'loop process' }
BlHostPulseLoop >> processId [

	^ self class processId
]

{ #category : #'loop process' }
BlHostPulseLoop >> processPriority [

	^ 40
]

{ #category : #period }
BlHostPulseLoop >> pulsePeriod [

	^ pulsePeriodMS milliSeconds
]

{ #category : #period }
BlHostPulseLoop >> pulsePeriod: aDuration [

	pulsePeriodMS := aDuration asMilliSeconds.
	msToWaitForBackgroundProcess := (pulsePeriodMS // 2) min: 1.
]

{ #category : #lifecycle }
BlHostPulseLoop >> start [

	self isRunning ifTrue: [ ^ self ].

	loopProcess := self newLoopProcess.
	loopProcess resume
]

{ #category : #lifecycle }
BlHostPulseLoop >> stop [

	| currentProcess |

	self isRunning ifFalse: [ ^ self ].
	
	currentProcess := loopProcess.
	loopProcess := nil.
	currentProcess terminate
]

{ #category : #period }
BlHostPulseLoop >> waitUntilNextPulse [
	"Wait the appropriate amount of time for the next pulse"

	| msToWait |
	"Since a pulse can take longer than #pulsePeriod, msToWait may be negative here
	(meaning that we shouldn't wait for the next pulse)"

	"No need to wait"	
	pulseDurationMS >= pulsePeriodMS ifTrue: [
		"Processor yield. maybe?" ^ self ].
	
	"Need to wait"
	msToWait := pulsePeriodMS - pulseDurationMS.
	(Delay forMilliseconds: msToWait) wait
]
