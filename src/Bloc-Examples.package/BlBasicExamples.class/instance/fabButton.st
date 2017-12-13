examples - buttons
fabButton
	<gtExample>
	| button icon |

	button := BlElement new
		background: (Color r: 255 g: 64 b: 129 range: 255);
		geometry: BlEllipse new;
		relocate: 100@100;
		size: 56@56;
		layout: BlFrameLayout new;
		effect: (BlDropShadowEffect color: (Color black alpha: 0.3) width: 1 offset: 0@2).

	icon := (BlPolygon vertices: ({
			36@0. 48@0 . 48@36 . 84@36.
			84@48 . 48@48 . 48@84 . 36@84.
			36@48 . 0@48 . 0@36. 36@36
		} collect: [ :aPoint | aPoint / 6.0])) asElement.

	icon background: Color white.
	icon border: BlBorder empty.
	icon constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].

	button addChild: icon.
	^ button