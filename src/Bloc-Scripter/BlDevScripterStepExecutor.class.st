Class {
	#name : 'BlDevScripterStepExecutor',
	#superclass : 'Object',
	#instVars : [
		'scripter',
		'strategy',
		'activities'
	],
	#category : 'Bloc-Scripter-Scripter-Executors',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Executors'
}

{ #category : 'accessing' }
BlDevScripterStepExecutor >> activities [
	^ activities
]

{ #category : 'accessing' }
BlDevScripterStepExecutor >> activities: anObject [
	activities := anObject
]

{ #category : 'initialization - activities' }
BlDevScripterStepExecutor >> addActivity: aBlDevScripterStepExecutorStepActivity [
	activities add: aBlDevScripterStepExecutorStepActivity
]

{ #category : 'asserting' }
BlDevScripterStepExecutor >> assertExecutableStep: aStep [
]

{ #category : 'initialization - execution' }
BlDevScripterStepExecutor >> async [
	self strategy: BlDevScripterStepExecutorAsyncStrategy new
]

{ #category : 'testing' }
BlDevScripterStepExecutor >> canBeExecuted: aStep [
	^ true
]

{ #category : 'private - execution' }
BlDevScripterStepExecutor >> executePostPlayActivitiesOnStep: aStep [
	self activities do: [ :eachActivity | 
		eachActivity executePostPlayOnStep: aStep executor: self ]
]

{ #category : 'private - execution' }
BlDevScripterStepExecutor >> executePrePlayActivitiesOnStep: aStep [
	self activities do: [ :eachActivity | 
		eachActivity executePrePlayOnStep: aStep executor: self ]
]

{ #category : 'actions' }
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

{ #category : 'actions' }
BlDevScripterStepExecutor >> executeStep: aStep [
	self assertExecutableStep: aStep.
	(self canBeExecuted: aStep) ifFalse: [ ^ self ].
	self executePrePlayActivitiesOnStep: aStep.
	[ 
		aStep isHaltState ifTrue: [ self halt ].
		aStep setUnderExecution.
		self strategy playStep: aStep executor: self.
		aStep setSuccessExecution.
		self executePostPlayActivitiesOnStep: aStep
	] 
		on: Error 
		do: [ :anException | 
			aStep setFailedExecution.
			self executePostPlayActivitiesOnStep: aStep.
			anException passWithScripter: self scripter. ]
]

{ #category : 'initialization' }
BlDevScripterStepExecutor >> initialize [
	super initialize.
	self sync.
	activities := OrderedCollection new.

	self withScreenshotExportOnFailure.
	self withEventsExportOnFailure
]

{ #category : 'actions' }
BlDevScripterStepExecutor >> play [
	self strategy startOnScripter: self scripter executor: self.
]

{ #category : 'accessing' }
BlDevScripterStepExecutor >> scripter [
	^ scripter
]

{ #category : 'accessing' }
BlDevScripterStepExecutor >> scripter: anObject [
	scripter := anObject
]

{ #category : 'accessing' }
BlDevScripterStepExecutor >> strategy [
	^ strategy
]

{ #category : 'accessing' }
BlDevScripterStepExecutor >> strategy: anObject [
	strategy := anObject
]

{ #category : 'initialization - execution' }
BlDevScripterStepExecutor >> sync [
	self strategy: BlDevScripterStepExecutorSyncStrategy new
]

{ #category : 'initialization - activities' }
BlDevScripterStepExecutor >> withEventsExportOnFailure [
	self addActivity: BlDevScripterStepExecutorEventsExportOnFailActivity new
]

{ #category : 'initialization - activities' }
BlDevScripterStepExecutor >> withScreenshotExportOnFailure [
	self addActivity: BlDevScripterStepExecutorScreenshotExportOnFailActivity new
]

{ #category : 'initialization - activities' }
BlDevScripterStepExecutor >> withScreenshots [
	self addActivity: BlDevScripterStepExecutorScreenshotActivity new
]
