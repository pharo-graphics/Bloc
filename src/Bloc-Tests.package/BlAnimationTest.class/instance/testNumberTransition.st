tests
testNumberTransition
|anim result finishFlag currenTime |
result := 0. 
finishFlag := false.
currenTime := Time millisecondClockValue.
anim := BlNumberTransition new
		from: 0;
		to: 100;
		duration: 500;
		onStepDo: [ :v | result := v ];
		onFinishedDo:[
			finishFlag := true. 
			currenTime := Time millisecondClockValue - currenTime].
		
anim start.
self assert:anim isRunning.
self assert: (BlUniverse default animationManager includesAnimation: anim).

(Delay forSeconds: 1) wait.

self assert: result = 100.
self assert:finishFlag.
self assert:(currenTime >= 500 and:[currenTime < 550]).
self assert:anim isRunning not.
self assert: (BlUniverse default animationManager includesAnimation: anim) not