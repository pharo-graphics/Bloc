I represent layout constraints and I am a superclass of all layout constraints.

Layouts that require additional properties must subclass be and add an extension method to ===BlLayoutCommonConstraints===

Since some constraints are also axis dependent (horizontal or vertical) I provide access to them through #horizontal and #vertical.

See ===BlLayoutConstraintsAxis=== to learn more about axis-dependent constraints