I a transformation builder and allow users to create and modify complex transformation chains.

Example of a builder that appends new transformations to existing ones:

element transform
	inherit;
	origin: (BlAffineTransformationPositionOrigin position: 0@0);
	translateBy: (BlVector x: 100 y: 100 z: 0);
	scaleBy: (BlVector x: 2 y: 0.5 z: 1);
	apply