as yet unclassified
testTaskProgress
	| theTask inUIProgressFlag noUIFlag inUIMessageFlag progressValue messageValue|
	inUIProgressFlag := inUIMessageFlag := noUIFlag := false.

	theTask := BlTask new: [ :task |
		noUIFlag := BlUniverse default isUIProcess not.
		task updateMessage:'Hello'.
		task updateProgress: 10 max: 10.].
			
	theTask progressProperty onChangedDo: [ :v | 
			inUIProgressFlag := BlUniverse default isUIProcess.
			progressValue := v].
	theTask messageProperty onChangedDo: [ :str | 
			inUIMessageFlag := BlUniverse default isUIProcess.
			messageValue := str].
	
	theTask start.
	(Delay forSeconds: 1) wait.
	
	self assert: noUIFlag description:'Task should be executed in  another process than the UI one'.
	self assert: inUIProgressFlag description:'Progress change should be done in the UI process'.
	self assert: inUIMessageFlag description:'Message change should be done in the UI process'.
	self assert: progressValue = 1 .
	self assert: messageValue = 'Hello'.	
	