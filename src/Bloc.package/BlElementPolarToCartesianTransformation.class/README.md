(Proof of concept)
I allow elements to define their position in polar coordinates

[[[
| container |
container := BlElement new.
container size: 200@200.
container relocate: 300@170.
container clipChildren: false.

(0 to: 200 by: 200 / 72.0) with: (0 to: 720 by: 10)
	do: [ :aRadius :anAngleInDegrees |
		container addChild: (BlElement new
			"define position of an element in Polar coordinates (R, phi)"
			relocate: aRadius @ anAngleInDegrees;
			"set transform from polar to cartesian coordinates"
			transformation: BlElementPolarToCartesianTransformation new;
			size: 3@3;
			background: Color gray;
			yourself) ].

container
]]]