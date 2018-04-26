! Geometry, Visual, and Layout Bounds Explained

A bound is a territorial limit, a boundary. In terms of a graphical element, it is a space in which the graphical element is rendered. For simplicity, bounds are rectangular areas. Bloc defines three different bounds (layout, geometry, and visual) that we will explain using the following example:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#centeredOutskirts|height=250|expanded=true|noCode=true|show=gtLiveIn:]]]

""Layout"" bounds are drawn with gray dashed rectangles in the figure above. They are of this size in this particula example, because each element defines its size explicitly using ==size:== method. Layout bounds are considered by layout algorithms to define mutual locations for all considered elements.

""Geometry"" bounds are drawn with red dashed rectangles in the figure above. The area is defined by minimum and maximum values of a polygon vertices. In case of rectangle, geometry bounds are defined by the following polygon:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#rectanglePolygon|expanded=true]]]

""Visual"" bounds are drawn with blue rectangles in the figure above. It is an exact area occupied by an element. Computing visual bounds is the most expensive computation as it takes strokes and rendering into account.

!! Different Bounds Setups

The first figure above draws all strokes centered around the defined vertices. For that reason, the geometry bounds are in the middle. The following example draws strokes outside:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#outsideOutskirts|height=250|expanded=true|noCode=true|show=gtLiveIn:]]]

In case of the rectangle, you can notice that its stroke is inside of the visual (blue, outside) and the geometry (red, inside) bounds. If the strokes are drawn inside, then visual and geometry bounds are igual:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#insideOutskirts|height=250|expanded=true|noCode=true|show=gtLiveIn:]]]


! Debugging Bounds

Being able to display those three bounds helps when elements are not visually aligned as expected. Consider the following example:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#misalignedIcon|expanded=true|noCode=false|show=gtLiveIn:]]]

The triangle (icon) and text are not horizontally centered despide the fact that we have ==BlLinearLayout horizontal alignCenter== in the code. To understand why it happens, ==aTriangleElement debug: true== can be added to the code with the following result:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#debuggingMisalignedIcon|expanded=true|noCode=false|show=gtLiveIn:]]]

As we can see the layout bounds (gray dashed rectangle) consider larger area then expected. Looking at the definition of the triangle polygon, we can spot that the polygon starts at ==0@3== instead of ==0@0==: 

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#misalignedTrianglePolygon|expanded=true]]]

If we fix it to: 

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#trianglePolygon|expanded=true]]]

The icon and text is aligned as expected:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#debuggingAlignedIcon|expanded=true|noCode=false|show=gtLiveIn:]]]

And we can disactivate the debug mode:

[[[example=BlGeometryVisualAndLayoutBoundsExamples>>#alignedIcon|expanded=true|noCode=false|show=gtLiveIn:]]]

The debugging mode is also possible to activate in the GT-Inspector's menu, next to the tabs.