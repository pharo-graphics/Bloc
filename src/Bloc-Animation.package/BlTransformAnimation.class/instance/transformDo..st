builder
transformDo: aBlock
	| aTransformationBuilder |

	aTransformationBuilder := self transform.
	aBlock value: aTransformationBuilder.
	aTransformationBuilder apply