## Element property

When dealing with properties of a visual element we often find ourselves in a situation when some properties should be propagated to children or should be resolved in a local context (pt units), in a context of the direct parent (em units) or even in a global context of the whole scene graph (rem units). In some othercases, properties can be added, removed or changed multiple times per frame. Ideally, we would like to actually modify element's state at most once per frame. `BlElementProperty` helps us to do exactly that.

### Understanding properties with status

`BlElementProperty` is independent from a `BlElement`, which allows us to store properties separately or even share between multiple elements. While this being a useful property it does not facilitate the ability to track if a property is applied on a specific element. This is were  `BlElementPropertyWithStatus` decorator comes into play. It wraps around element property and adds a status flag: applied, just added or to be removed.
The status flag is an elegant approach to the performance optimization problem. When switching element styles it is common that properties are removed and then added back (with the same or maybe a different value).
As an example let's consider the background of an element. Here is what roughly happens when the background is changed from black to white color:

1. Convert  Color to `BlBackground`
2. Perform a comparison of the current  `BlElement>>#background` with the new one and do nothing if they are equal.
3. Change the background instance variable value to the new one and request an element to redraw.

If for example the background is changed back from white to black within the same frame the element should perform the same 3 operations, so in total it would be 6 expensive step. Visually, however, nothing changed. By adding a status flag to the property we are able to minimize the amount of expensive modifications of the element's state.

### Accessing element properties

Each element knows a collection of properties currently applied on that element (BlElementCurrentProperties). They can be accessed by sending `BlElement>>#properties` to an element.
Consider the following element with a few properties that define its look:

`BlElementPropertyExplanation>>#elementWithMultipleProperties`

Sending `BlElement>>#properties` reveals what properties are currently applied: Check `BlElementPropertyExplanation>>#elementWithMultipleProperties`

### Adding and removing properties
An instance of  `BlElementProperty` can be added to any arbitrary element by sending  `BlElementCurrentProperties>>#addProperty:` and removed by sending  `BlElementCurrentProperties>>#removeProperty:` to the collection of properties previously obtained with the help of `BlElement>>#properties`. From here Bloc will take care of the rest. Please note, that adding and removing properties does not have an immediate effect, all modifications done to the properties are batched and performed as part of the  `BlSpaceFramePropertiesPhase`.

### Properties clean up after themselves

Each property knows how to apply itself on an element (`BlElementProperty>>#applyOnElement:`) and how to clean up after itself (`BlElementProperty>>#cleanUpOnElement:`). Both methods are optional and users do not have to override them, however, it is preferable to provide both implementations when applicable.
As an example let's take a  BlElementBackgroundProperty which implements both methods:
`BlElementPropertyExamples>>#backgroundProperty`
Click on the buttons to the left from the rectangular element to see what happens when the background property is added and then removed from an element: once executed `BlElementPropertyExplanation>>#propertyCleanUp`.
 

