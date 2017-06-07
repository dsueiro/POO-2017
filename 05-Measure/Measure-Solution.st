!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'accessing' stamp: 'DHS 6/6/2017 20:12:16'!
amount: anAmount 
	amount := anAmount! !

!Measure methodsFor: 'accessing' stamp: 'DHS 6/6/2017 20:12:49'!
unit: anUnit 
	unit := anUnit! !


!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:40:41'!
+ aMeasure 
	^Measure newWith: (aMeasure addAmountInReferenceUnit: self amountInReferenceUnit) in: self referenceUnit ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:46:00'!
addAmountInReferenceUnit: anAmount 
	^self amountInReferenceUnit + anAmount! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:25:22'!
amount
	^amount! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:42:11'!
amountInReferenceUnit
	^amount * unit conversionFactor! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:30:16'!
referenceUnit
	^unit referenceUnit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:28:13'!
unit
	^unit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:11:37'!
newWith: anAmount in: aUnit
	^self new amount: anAmount; unit: aUnit; yourself! !


!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'unMetroCuadrado dosMetrosCuadrados unKilo dosKilos gramo metro unGramo dosGramos unMetro unidadDeMasa unidadDeDistancia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:32:31'!
setUp
	unidadDeMasa :=  ReferenceUnit withSymbol: 'referenceMass'.
	unidadDeDistancia :=  ReferenceUnit withSymbol: 'referenceDistance'.
	gramo := DerivedUnit withConversionFactor: 1.0 withReferenceUnit: unidadDeMasa withSymbol: 'g'.
	metro := DerivedUnit withConversionFactor: 1.0 withReferenceUnit: unidadDeDistancia withSymbol: 'm'.
	unGramo := Measure newWith: 1.0 in: gramo.
	dosGramos := Measure newWith: 2.0 in: gramo.
	unMetro := Measure newWith: 1.0 in: metro! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:34:41'!
test01UnGramoIgualUnGramo
	self assert: unGramo = unGramo! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:34:51'!
test02UnGramoDistintoADosGramos
	self deny: unGramo = dosGramos! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:35:01'!
test03UnGramoDistintoAUnMetro
	self deny: unGramo = unMetro! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:35:34'!
test04UnGramoMasUnGramoEsDosGramos
	self assert: unGramo + unGramo = dosGramos! !


!classDefinition: #DerivedUnit category: #'Measure-Solution'!
Object subclass: #DerivedUnit
	instanceVariableNames: 'conversionFactor unitSymbol referenceUnit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:08:44'!
conversionFactor
	^conversionFactor! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:06:49'!
conversionFactor: aConversionFactor 
	conversionFactor := aConversionFactor! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:09:49'!
referenceUnit
	^referenceUnit! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:07:14'!
referenceUnit: aReferenceUnit 
	referenceUnit := aReferenceUnit! !

!DerivedUnit methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:07:50'!
unitSymbol: aUnitSymbol
	unitSymbol := aUnitSymbol! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DerivedUnit class' category: #'Measure-Solution'!
DerivedUnit class
	instanceVariableNames: ''!

!DerivedUnit class methodsFor: 'nil' stamp: 'DHS 6/6/2017 21:01:19'!
withConversionFactor: aConversionFactor withSymbol: aUnitSymbol
	^self new conversionFactor: aConversionFactor; unitSymbol: aUnitSymbol; yourself! !


!DerivedUnit class methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:06:04'!
withConversionFactor: aConversionFactor withReferenceUnit: aReferenceUnit withSymbol: aUnitSymbol 
		^self new conversionFactor: aConversionFactor; referenceUnit: aReferenceUnit; unitSymbol: aUnitSymbol; yourself! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'referenceUnit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:45:21'!
conversionFactor
	^conversionFactor! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:07:32'!
conversionFactor: aConversionFactor
	conversionFactor := aConversionFactor! !


!Unit methodsFor: 'accessing' stamp: 'DHS 6/6/2017 20:08:34'!
unitSymbol: aUnitSymbol 
	unitSymbol := aUnitSymbol! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: 'conversionFactor symbol'!


!classDefinition: #ReferenceUnit category: #'Measure-Solution'!
Unit subclass: #ReferenceUnit
	instanceVariableNames: 'unitSymbol'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!ReferenceUnit methodsFor: 'nil' stamp: 'DHS 6/6/2017 21:13:38'!
conversionFactor
	^1.0! !


!ReferenceUnit methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:35:53'!
referenceUnit
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReferenceUnit class' category: #'Measure-Solution'!
ReferenceUnit class
	instanceVariableNames: ''!

!ReferenceUnit class methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:04:38'!
withSymbol: aUnitSymbol 
	^self new unitSymbol: aUnitSymbol! !
