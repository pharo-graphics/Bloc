Class {
	#name : #BlAnimationTest,
	#superclass : #TestCase,
	#category : 'Bloc-Animation-Tests'
}

{ #category : #tests }
BlAnimationTest >> _testColorTransition [
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
]

{ #category : #tests }
BlAnimationTest >> _testNumberTransition [
	| anim result finishFlag currenTime |
	result := 0.
	finishFlag := false.
	currenTime := Time millisecondClockValue.

	anim := BlNumberTransition new
		from: 0;
		to: 100;
		duration: 500;
		onStepDo: [ :v | result := v ];
		onFinishedDo: [ finishFlag := true.
			currenTime := Time millisecondClockValue - currenTime ].
	anim start.

	self assert: anim isRunning.
	self assert: (BlUniverse default animationManager includesAnimation: anim).
	(Delay forSeconds: 1) wait.
	self assert: result equals: 100.
	self assert: finishFlag.
	self assert: (currenTime >= 500 and: [ currenTime < 550 ]).
	self assert: anim isRunning not.
	self assert: (BlUniverse default animationManager includesAnimation: anim) not
]

{ #category : #tests }
BlAnimationTest >> _testParallelAnimation [
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
]

{ #category : #tests }
BlAnimationTest >> _testSequentialAnimation [
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
]

{ #category : #initialization }
BlAnimationTest >> setUp [
	BlUniverse reset.
	BlUniverse default start
]

{ #category : #initialization }
BlAnimationTest >> tearDown [
	super tearDown.
	
	BlUniverse default stop.
	BlUniverse reset
]
