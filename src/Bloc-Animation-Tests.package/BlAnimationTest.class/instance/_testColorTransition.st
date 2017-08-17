tests
_testColorTransition
	| anim result finishFlag currenTime |

	result := Color black alpha: 0.
	finishFlag := false.
	currenTime := Time millisecondClockValue.
	anim := BlColorTransition new
		from: (Color black alpha: 0);
		to: (Color black alpha: 1);
		duration: 500;
		onStepDo: [ :v | result := v ];
		onFinishedDo: [ finishFlag := true.
			currenTime := Time millisecondClockValue - currenTime ].
	anim start.
	self assert: anim isRunning.
	self assert: (BlUniverse default animationManager includesAnimation: anim).
	(Delay forSeconds: 1) wait.
	self assert: result = (Color black alpha: 1).
	self assert: finishFlag.
	self assert: (currenTime >= 500 and: [ currenTime < 550 ]).
	self assert: anim isRunning not.
	self assert: (BlUniverse default animationManager includesAnimation: anim) not