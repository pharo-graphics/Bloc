"
Some example on applying effect on a bloc element
"
Class {
	#name : #EffectExperiment,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-Bloc'
}

{ #category : #examples }
EffectExperiment class >> effectComposite [
<demo>
	<sampleInstance>
	| compositeEffect |
	compositeEffect := BlCompositeEffect effects: {
			                   (BlGaussianShadowEffect
				                    color: Color red
				                    width: 3
				                    offset: 7 @ 11).
			                   (BlGaussianShadowEffect
				                    color: Color green
				                    width: 7
				                    offset: -5 @ 7).
			                   (BlGaussianShadowEffect
				                    color: Color blue
				                    width: 11
				                    offset: 7 @ -5) }.
	^ BlElement new
		  size: 300 @ 150;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  background: (Color blue alpha: 0.5);
		  border: (BlBorder paint: Color red width: 10);
		  effect: compositeEffect
]

{ #category : #examples }
EffectExperiment class >> effectGaussianShadow [
<demo>
	<sampleInstance>
	^ BlElement new
		  size: 300 @ 150;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  background: (Color blue alpha: 0.5);
		  border: (BlBorder paint: Color red width: 10);
		  effect:
			  (BlGaussianShadowEffect
				   color: Color yellow
				   offset: 10 @ 20
				   width: 5)
]

{ #category : #examples }
EffectExperiment class >> effectSimpleShadow [
<demo>
	<sampleInstance>
	^ BlElement new
		  size: 300 @ 150;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  background: (Color blue alpha: 0.5);
		  border: (BlBorder paint: Color red width: 10);
		  effect: (BlSimpleShadowEffect color: Color yellow offset: 10 @ 20)
]

{ #category : #examples }
EffectExperiment class >> effectSimpleShadow2 [
<demo>
	<sampleInstance>
	^ BlElement new
		  size: 200 @ 100;
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  background: (Color red alpha: 0.2);
		  border: (BlBorder paint: Color yellow width: 1);
		  "layout: BlLinearLayout horizontal alignCenter;""constraintsDo: [:c | c horizontal matchParent. c vertical matchParent.];"
		  outskirts: BlOutskirts centered;
		  effect:
			  (BlSimpleShadowEffect color: Color orange offset: -10 @ -20)
]

{ #category : #'see class side' }
EffectExperiment >> seeClassSide [ 
]
