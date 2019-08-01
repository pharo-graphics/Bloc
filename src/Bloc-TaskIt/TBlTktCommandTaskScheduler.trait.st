Trait {
	#name : #TBlTktCommandTaskScheduler,
	#category : #'Bloc-TaskIt-Workers'
}

{ #category : #schedulling }
TBlTktCommandTaskScheduler >> future: aTask [
	<return: #TKTFuture>
	^ self withConfigurationDo: [ super future: aTask ].
]

{ #category : #accessing }
TBlTktCommandTaskScheduler >> processProvider [
	^ TKTConfiguration processProvider
]

{ #category : #schedulling }
TBlTktCommandTaskScheduler >> schedule: aTask [
	self withConfigurationDo: [ super schedule: aTask ].
]

{ #category : #schedulling }
TBlTktCommandTaskScheduler >> schedule: aTask timeout: aTimeout [
	self withConfigurationDo: [ super schedule: aTask timeout: aTimeout ].
]

{ #category : #private }
TBlTktCommandTaskScheduler >> withConfigurationDo: aBlock [
	^ TKTConfiguration 
		processProvider: self processProvider 
		during: aBlock
]
