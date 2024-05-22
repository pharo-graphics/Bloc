"
animation experiment and example in Bloc
"
Class {
	#name : #AnimationExperiment,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-Bloc'
}

{ #category : #examples }
AnimationExperiment class >> GaussianEffectAnimation [
<demo>
	<sampleInstance>
	| element animation |
	element := BlElement new
		           size: 150 @ 150;
		           position: 25 @ 25;
		           background: Color yellow;
		           border: (BlBorder paint: Color red width: 3).

	animation := BlGaussianEffectOpacityAnimation new
		             delay: 1 second;
		             color: Color red;
		             width: 25;
		             opacity: 0.9;
		             duration: 300 milliSeconds.

	element addAnimation: animation.
	^ element
]

{ #category : #examples }
AnimationExperiment class >> animatedBackground [
<demo>
	<sampleInstance>
	| element animation |
	element := BlElement new size: 50 @ 50.

	animation := BlNumberTransition new
		             from: 0;
		             to: 1;
		             by: 0.5;
		             beInfinite;
		             duration: 3 seconds;
		             onStepDo: [ :aValue :anElement |
			             aValue < 0.5
				             ifTrue: [ anElement background: Color red ]
				             ifFalse: [ anElement background: Color blue ] ].

	element addAnimation: animation.
	^ element
]

{ #category : #examples }
AnimationExperiment class >> animatedBackground2 [
<demo>
	<sampleInstance>
	| element animation |
	element := BlElement new size: 50 @ 50.

	animation := BlNumberTransition new
		             from: 0;
		             to: 1;
		             by: 0.5;
		             loops: 5;
		             duration: 3 seconds;
		             "onStepDo: is called on every space pulse. Color are updated at each pulse..."
		             onStepDo: [ :aValue :anElement |
			             aValue < 0.5
				             ifTrue: [ anElement background: Color random ]
				             ifFalse: [ anElement background: Color blue ] ].

	element addAnimation: animation.
	^ element
]

{ #category : #examples }
AnimationExperiment class >> crossElement [

	<demo>
	<sampleInstance>
	| cross w h animation |
	w := 200.
	h := 200.
	cross := BlElement new
		         size: w @ h;
		         background: (BlBackground paint: (Color blue alpha: 0.2));
		         border: (BlBorder paint: Color black width: 2);
		         geometry: (BlPolygonGeometry vertices: {
						          (w / 3 @ 0).
						          (w / 3 * 2 @ 0).
						          (w / 3 * 2 @ (h / 3)).
						          (w @ (h / 3)).
						          (w @ (h / 3 * 2)).
						          (w / 3 * 2 @ (h / 3 * 2)).
						          (w / 3 * 2 @ h).
						          (w / 3 @ h).
						          (w / 3 @ (h / 3 * 2)).
						          (0 @ (h / 3 * 2)).
						          (0 @ (h / 3)).
						          (w / 3 @ (h / 3)) });
		         position: 30 @ 30.
	cross addEventHandler: (BlEventHandler
			 on: BlMouseEnterEvent
			 do: [ :anEvent | cross background: (Color red alpha: 0.2) ]).

	cross addEventHandler: (BlEventHandler
			 on: BlMouseLeaveEvent
			 do: [ :anEvent | cross background: (Color yellow alpha: 0.2) ]).

	cross addShortcut: (BlShortcutWithAction new
			 combination: (BlSingleKeyCombination key: KeyboardKey up);
			 action: [ :anEvent :aShortcut |
				 cross position: cross position - (0 @ 10) ]).

	cross addShortcut: (BlShortcutWithAction new
			 combination: (BlSingleKeyCombination key: KeyboardKey right);
			 action: [ :anEvent :aShortcut |
				 cross position: cross position + (10 @ 0) ]).

	cross addShortcut: (BlShortcutWithAction new
			 combination: (BlSingleKeyCombination key: KeyboardKey left);
			 action: [ :anEvent :aShortcut |
				 cross position: cross position - (10 @ 0) ]).

	cross addShortcut: (BlShortcutWithAction new
			 combination: (BlSingleKeyCombination key: KeyboardKey down);
			 action: [ :anEvent :aShortcut |
				 cross position: cross position + (0 @ 10) ]).

	animation := BlNumberTransition new
		             from: 0;
		             to: 1;
		             by: 0.5;
		             beInfinite;
		             duration: 3 seconds;
		             onStepDo: [ :aValue :anElement |
			             aValue < 0.5
				             ifTrue: [ anElement background: Color red ]
				             ifFalse: [ anElement background: Color blue ] ].

	cross addAnimation: animation.

	cross addShortcut: (BlShortcutWithAction new
			 combination: (BlSingleKeyCombination key: KeyboardKey S);
			 action: [ :anEvent :aShortcut | animation start ]).

	cross addShortcut: (BlShortcutWithAction new
			 combination: (BlSingleKeyCombination key: KeyboardKey E);
			 action: [ :anEvent :aShortcut | animation stop ]).

	cross requestFocus.
	^ cross
]

{ #category : #examples }
AnimationExperiment class >> opacityAnimation [

<demo>
	<sampleInstance>
	| element animation |
	element := BlElement new
		           size: 150 @ 150;
		           background: Color yellow;
		           border: (BlBorder paint: Color red width: 3).

	animation := BlOpacityAnimation new
		             delay: 1 second;
		             opacity: 0.1;
		             duration: 300 milliSeconds.

	element addAnimation: animation.

	^ element
]

{ #category : #examples }
AnimationExperiment class >> sequentialBounceIn [

	<demo>
	<sampleInstance>
	| element translation scale sequential |
	translation := (BlTransformAnimation translate: 300 @ 300)
		               easing: BlEasing bounceIn;
		               duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		         easing: BlEasing bounceIn;
		         duration: 2 seconds.

	sequential := BlSequentialAnimation new addAll: {
			              translation.
			              scale }.

	element := BlElement new
		           background: Color blue;
		           size: 100 @ 100;
		           position: 100 @ 100.
	element addAnimation: sequential.

	^ element
]

{ #category : #examples }
AnimationExperiment class >> sequentialBounceInOut [
<demo>
	<sampleInstance>
	| element translation scale sequential |
	translation := (BlTransformAnimation translate: 300 @ 300)
		               easing: BlEasing bounceInOut;
		               duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		         easing: BlEasing bounceInOut;
		         duration: 2 seconds.

	sequential := BlSequentialAnimation new addAll: {
			              translation.
			              scale }.

	element := BlElement new
		           background: Color blue;
		           size: 100 @ 100;
		           position: 100 @ 100.
	element addAnimation: sequential.

	^ element
]

{ #category : #examples }
AnimationExperiment class >> sequentialBounceOut [

	<demo>
	<sampleInstance>
	| element translation scale sequential |
	translation := (BlTransformAnimation translate: 300 @ 300)
		               easing: BlEasing bounceOut;
		               duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		         easing: BlEasing bounceOut;
		         duration: 2 seconds.

	sequential := BlSequentialAnimation new addAll: {
			              translation.
			              scale }.

	element := BlElement new
		           background: Color blue;
		           size: 100 @ 100;
		           position: 100 @ 100.
	element addAnimation: sequential.

	^ element
]

{ #category : #examples }
AnimationExperiment class >> sequentialElastic [
<demo>
	<sampleInstance>
	| element translation scale sequential |
	translation := (BlTransformAnimation translate: 300 @ 300)
		               easing: BlEasingElastic new;
		               duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		         easing: BlEasingElastic new;
		         duration: 2 seconds.

	sequential := BlSequentialAnimation new addAll: {
			              translation.
			              scale }.

	element := BlElement new
		           background: Color blue;
		           size: 100 @ 100;
		           position: 100 @ 100.
	element addAnimation: sequential.

	^ element
]

{ #category : #examples }
AnimationExperiment class >> sequentialQuad [
<demo>
	<sampleInstance>
	| element translation scale sequential |
	translation := (BlTransformAnimation translate: 300 @ 300)
		               easing: BlEasingQuad new;
		               duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		         easing: BlEasingQuad new;
		         duration: 2 seconds.

	sequential := BlSequentialAnimation new addAll: {
			              translation.
			              scale }.

	element := BlElement new
		           background: Color blue;
		           size: 100 @ 100;
		           position: 100 @ 100.
	element addAnimation: sequential.

	^ element
]

{ #category : #examples }
AnimationExperiment class >> sequentialQuintic [
<demo>
	<sampleInstance>
	| element translation scale sequential |
	translation := (BlTransformAnimation translate: 300 @ 300)
		               easing: BlQuinticInterpolator new;
		               duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		         easing: BlQuinticInterpolator new;
		         duration: 2 seconds.

	sequential := BlSequentialAnimation new addAll: {
			              translation.
			              scale }.

	element := BlElement new
		           background: Color blue;
		           size: 100 @ 100;
		           position: 100 @ 100.
	element addAnimation: sequential.

	^ element
]

{ #category : #examples }
AnimationExperiment class >> sequentialSine [
<demo>
	<sampleInstance>
	| element translation scale sequential |
	translation := (BlTransformAnimation translate: 300 @ 300)
		               easing: BlSineInterpolator new;
		               duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		         easing: BlSineInterpolator new;
		         duration: 2 seconds.

	sequential := BlSequentialAnimation new addAll: {
			              translation.
			              scale }.

	element := BlElement new
		           background: Color blue;
		           size: 100 @ 100;
		           position: 100 @ 100.
	element addAnimation: sequential.

	^ element
]

{ #category : #examples }
AnimationExperiment class >> sequentialViscousFluid [
<demo>
	<sampleInstance>
	| element translation scale sequential |
	translation := (BlTransformAnimation translate: 300 @ 300)
		               easing: BlViscousFluidInterpolator new;
		               duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		         easing: BlViscousFluidInterpolator new;
		         duration: 2 seconds.

	sequential := BlSequentialAnimation new addAll: {
			              translation.
			              scale }.

	element := BlElement new
		           background: Color blue;
		           size: 100 @ 100;
		           position: 100 @ 100.
	element addAnimation: sequential.

	^ element
]

{ #category : #'see class side' }
AnimationExperiment >> seeClassSide [ 
]
