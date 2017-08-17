tests
_testSequentialAnimation
	| anim animNum resultNum finishNumFlag currenTimeNum animColor resultColor finishColorFlag currenTimeColor |
	"I don't know why sometime this test failed..."
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
	anim := BlSequentialAnimation new
		add: animNum;
		add: animColor.
	anim start.
	self assert: anim isRunning.
	self assert: animNum isRunning.
	self assert: (BlUniverse default animationManager includesAnimation: anim).
	(Delay forMilliseconds: 800) wait.
	self assert: animNum isRunning not.
	self assert: animColor isRunning.
	(Delay forSeconds: 1) wait.
	self assert: resultNum = 100.
	self assert: resultColor = (Color black alpha: 1).
	self assert: finishColorFlag.
	self assert: finishNumFlag.
	self assert: (currenTimeNum >= 500 and: [ currenTimeNum < 550 ]).
	self assert: (currenTimeColor >= 1000 and: [ currenTimeColor < 1050 ]).
	self assert: anim isRunning not.
	self assert: animNum isRunning not.
	self assert: animColor isRunning not.
	self assert: (BlUniverse default animationManager includesAnimation: anim) not