"
A BlSequentialAnimationTest is a test class for testing the behavior of BlSequentialAnimation
"
Class {
	#name : #BlSequentialAnimationTest,
	#superclass : #TestCase,
	#category : #'Bloc-Animation-Tests'
}

{ #category : #tests }
BlSequentialAnimationTest >> testDoNotFinishEarlyLastAnimation [
	"See: https://github.com/pharo-graphics/Bloc/issues/194"

	| aDuration initialDelay aTime log animation1 animation2 animationSequence |
	aDuration := 100 milliSeconds.
	initialDelay := 200 milliSeconds.

	aTime := BlTime simulated
		date: DateAndTime midnight;
		yourself.

	log := OrderedCollection new.

	animation1 :=
		BlNumberTransition new
			time: aTime;
			from: 0.0;
			to: 1.0;
			delay: initialDelay;
			duration: aDuration;
			onStepDo: [ :t | ];
			addEventHandlerOn: BlAnimationStepEvent
				do: [ :evt | log add: (evt progress -> 1) ];
			yourself.
	animation2 :=
		BlNumberTransition new
			time: aTime;
			from: 0.0;
			to: 1.0;
			onStepDo: [ :t | ];
			addEventHandlerOn: BlAnimationStepEvent
				do: [ :evt | log add: (evt progress -> 2) ];
			duration: aDuration;
			yourself.
	animationSequence :=
		BlSequentialAnimation new 
			time: aTime;
			add: animation1;
			add: animation2;
			addEventHandlerOn: BlAnimationStepEvent
				do: [ :evt | log add: (evt progress -> #s) ];
			beInfinite;
			yourself.

	aTime wait: initialDelay. animationSequence run.

	14 timesRepeat: [
		aTime wait: aDuration - 57 milliSeconds. animationSequence run].

	"Last animation in the sequence must reach progress=1.0. Even if the
	sequential animation that contains it already reached it (workaround?)"
	self assert: (log includes: (1.0 -> 2)).
	self assert: (log count: [ :each | each = (1.0 -> #s)]) equals: 2
]
