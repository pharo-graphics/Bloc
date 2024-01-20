Class {
	#name : #BlDevScripterStepExecutor,
	#superclass : #Object,
	#instVars : [
		'scripter',
		'strategy',
		'activities'
	],
	#category : #'Bloc-Scripter-Scripter-Executors'
}

{ #category : #accessing }
BlDevScripterStepExecutor >> activities [

	^ activities
]

{ #category : #accessing }
BlDevScripterStepExecutor >> activities: aCollection [

	activities := aCollection
]

{ #category : #'initialization - activities' }
BlDevScripterStepExecutor >> addActivity: aBlDevScripterStepExecutorStepActivity [

	activities add: aBlDevScripterStepExecutorStepActivity
]

{ #category : #asserting }
BlDevScripterStepExecutor >> assertExecutableStep: aStep [
]

{ #category : #'initialization - execution' }
BlDevScripterStepExecutor >> async [

	self strategy: BlDevScripterStepExecutorAsyncStrategy new
]

{ #category : #testing }
BlDevScripterStepExecutor >> canBeExecuted: aStep [

	^ true
]

{ #category : #'private - execution' }
BlDevScripterStepExecutor >> executePostPlayActivitiesOnStep: aStep [

	activities do: [ :eachActivity |
		eachActivity executePostPlayOnStep: aStep executor: self ]
]

{ #category : #'private - execution' }
BlDevScripterStepExecutor >> executePrePlayActivitiesOnStep: aStep [

	activities do: [ :eachActivity |
		eachActivity executePrePlayOnStep: aStep executor: self ]
]

{ #category : #actions }
BlDevScripterStepExecutor >> executeRootStep: aStep [

	self executePrePlayActivitiesOnStep: aStep.
	[ 
		aStep isHaltState ifTrue: [ self halt ].
		aStep setUnderExecution.
		aStep steps do: [ :eachStep | self executeStep: eachStep ].
		aStep setSuccessExecution.
		self executePostPlayActivitiesOnStep: aStep
	]
		on: Error 
		do: [ :anException | 
			aStep setFailedExecution.
			self executePostPlayActivitiesOnStep: aStep.
			anException pass ]
]

{ #category : #actions }
BlDevScripterStepExecutor >> executeStep: aStep [

	self assertExecutableStep: aStep.
	(self canBeExecuted: aStep) ifFalse: [ ^ self ].
	self executePrePlayActivitiesOnStep: aStep.
	[ 
		aStep isHaltState ifTrue: [ self halt ].
		aStep setUnderExecution.
		strategy playStep: aStep executor: self.
		aStep setSuccessExecution.
		self executePostPlayActivitiesOnStep: aStep
	] 
		on: Error 
		do: [ :anException | 
			aStep setFailedExecution.
			self executePostPlayActivitiesOnStep: aStep.
			anException passWithScripter: scripter ]
]

{ #category : #initialization }
BlDevScripterStepExecutor >> initialize [

	super initialize.
	self sync.
	activities := OrderedCollection new.

	self withScreenshotExportOnFailure.
	self withEventsExportOnFailure
]

{ #category : #actions }
BlDevScripterStepExecutor >> play [

	strategy startOnScripter: scripter executor: self
]

{ #category : #accessing }
BlDevScripterStepExecutor >> scripter [

	^ scripter
]

{ #category : #accessing }
BlDevScripterStepExecutor >> scripter: aBlDevScripter [

	scripter := aBlDevScripter
]

{ #category : #accessing }
BlDevScripterStepExecutor >> strategy [

	^ strategy
]

{ #category : #accessing }
BlDevScripterStepExecutor >> strategy: aBlDevScripterStepExecutorStrategy [

	strategy := aBlDevScripterStepExecutorStrategy
]

{ #category : #'initialization - execution' }
BlDevScripterStepExecutor >> sync [

	self strategy: BlDevScripterStepExecutorSyncStrategy new
]

{ #category : #'initialization - activities' }
BlDevScripterStepExecutor >> withEventsExportOnFailure [

	self addActivity:
		BlDevScripterStepExecutorEventsExportOnFailActivity new
]

{ #category : #'initialization - activities' }
BlDevScripterStepExecutor >> withScreenshotExportOnFailure [

	self addActivity:
		BlDevScripterStepExecutorScreenshotExportOnFailActivity new
]

{ #category : #'initialization - activities' }
BlDevScripterStepExecutor >> withScreenshots [

	self addActivity: BlDevScripterStepExecutorScreenshotActivity new
]
