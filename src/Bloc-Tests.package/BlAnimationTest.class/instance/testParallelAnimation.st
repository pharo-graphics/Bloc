tests
testParallelAnimation
	| anim animNum resultNum finishNumFlag currenTimeNum animColor resultColor finishColorFlag currenTimeColor |
	currenTimeNum := Time millisecondClockValue.
	currenTimeColor := Time millisecondClockValue.
	resultNum := 0.
	resultColor := Color black alpha: 0.
	finishColorFlag := finishNumFlag := false.

	animColor := BlColorTransition new
		from: (Color black alpha: 0);
		to: (Color black alpha: 1);
		duration: 500;
		onStepDo: [ :v | resultColor := v ];
		onFinishedDo: [ finishColorFlag := true.
			currenTimeColor := Time millisecondClockValue - currenTimeColor ].
	animNum := BlNumberTransition new
		from: 0;
		to: 100;
		duration: 500;
		onStepDo: [ :v | resultNum := v ];
		onFinishedDo: [ finishNumFlag := true.
			currenTimeNum := Time millisecondClockValue - currenTimeNum ].
	anim := BlParallelAnimation new
		add: animNum;
		add: animColor.
	anim start.
	self assert: anim isRunning.
	self assert: animNum isRunning.
	self assert: animColor isRunning.
	self assert: (BlUniverse default animationManager includesAnimation: anim).
	(Delay forSeconds: 1) wait.
	self assert: resultNum = 100.
	self assert: resultColor = (Color black alpha: 1).
	self assert: finishColorFlag.
	self assert: finishNumFlag.
	self assert: (currenTimeColor >= 500 and: [ currenTimeColor < 550 ]).
	self assert: (currenTimeNum >= 500 and: [ currenTimeNum < 550 ]).
	self assert: anim isRunning not.
	self assert: animNum isRunning not.
	self assert: animColor isRunning not.
	self assert: (BlUniverse default animationManager includesAnimation: anim) not