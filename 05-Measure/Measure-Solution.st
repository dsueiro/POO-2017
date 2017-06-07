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


!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:06:07'!
* aNumber
	^Measure newWith: (self amountInReferenceUnit * aNumber) in: self referenceUnit ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:40:41'!
+ aMeasure 
	^Measure newWith: (aMeasure addAmountInReferenceUnit: self amountInReferenceUnit) in: self referenceUnit ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 06:28:41'!
- aMeasure 
	^Measure newWith: (aMeasure substractAmountInReferenceUnit: self amountInReferenceUnit) in: self referenceUnit ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:13:17'!
/ aNumber
	^Measure newWith: (self amountInReferenceUnit / aNumber ) in: self referenceUnit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:20:56'!
< aMeasure 
	^aMeasure amountInReferenceUnitIsGreaterThan: self amountInReferenceUnit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:00:49'!
= aMeasure
	^aMeasure amountInReferenceUnitEquals: self amountInReferenceUnit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:08:23'!
adaptToInteger: aNumber andSend: aSelector
	^ self perform: aSelector with: aNumber! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:46:00'!
addAmountInReferenceUnit: anAmount 
	^self amountInReferenceUnit + anAmount! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:25:22'!
amount
	^amount! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 20:42:11'!
amountInReferenceUnit
	^amount * unit conversionFactor! !

!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 06:21:44'!
amountInReferenceUnitEquals: anAmount 
	^self amountInReferenceUnit = anAmount! !

!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:22:39'!
amountInReferenceUnitIsGreaterThan: anAmountInReferenceUnit
	^self amountInReferenceUnit > anAmountInReferenceUnit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DHS 6/6/2017 21:30:16'!
referenceUnit
	^unit referenceUnit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 06:35:42'!
substractAmountInReferenceUnit: anAmountInReferenceUnit 
	^anAmountInReferenceUnit - self amountInReferenceUnit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:36:42'!
to: aMeasure 
	^MeasureInterval from: self to: aMeasure by: (Measure newWith: 1 in: self referenceUnit)! !

!Measure methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:46:52'!
to: aMeasure by: aMeasure2 
	^MeasureInterval from: self to: aMeasure by: aMeasure2 ! !

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
	instanceVariableNames: 'unMetroCuadrado dosMetrosCuadrados unKilo dosKilos gramo metro unGramo dosGramos unMetro unidadDeMasa unidadDeDistancia cienCentimetros centimetro dosMetros milMilimetros milimetro unMedioMetro diezKilometros kiloMetro tresMetros cincoCentimetros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:45:19'!
setUp
	unidadDeMasa :=  ReferenceUnit withSymbol: 'referenceMass'.
	unidadDeDistancia :=  ReferenceUnit withSymbol: 'referenceDistance'.
	gramo := DerivedUnit withConversionFactor: 1.0 withReferenceUnit: unidadDeMasa withSymbol: 'g'.
	metro := DerivedUnit withConversionFactor: 1.0 withReferenceUnit: unidadDeDistancia withSymbol: 'm'.
	centimetro := DerivedUnit withConversionFactor: 0.01 withReferenceUnit: unidadDeDistancia withSymbol: 'cm'.
	milimetro := DerivedUnit withConversionFactor: 0.001 withReferenceUnit: unidadDeDistancia withSymbol: 'mm'.
	kiloMetro := DerivedUnit withConversionFactor: 1.0 withReferenceUnit: unidadDeDistancia withSymbol: 'km'.
	unGramo := Measure newWith: 1.0 in: gramo.
	dosGramos := Measure newWith: 2.0 in: gramo.
	unMetro := Measure newWith: 1.0 in: metro.
	unMedioMetro := Measure newWith: 0.5 in: metro.
	diezKilometros := Measure newWith: 10 in: kiloMetro.
	dosMetros := Measure newWith: 2.0 in: metro.
	tresMetros := Measure newWith: 3.0 in: metro.
	cincoCentimetros := Measure newWith: 5 in: centimetro.
	cienCentimetros := Measure newWith: 100 in: centimetro.
	milMilimetros := Measure newWith: 1000 in: milimetro.! !

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

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 05:50:36'!
test05UnMetroEsIgualACienCentrimetros
	self assert: unMetro = cienCentimetros! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 06:27:37'!
test06DosMetrosMenosCienCentimetrosEsIgualaMilMilimetros
	self assert: (dosMetros - cienCentimetros) = milMilimetros! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:02:05'!
test07UnMetroEstrellaDosEsIgualADosMetros
	self assert: (unMetro * 2) = dosMetros ! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:07:48'!
test08DosEstrellaUnMetroEsIgualADosMetros
	self assert: (2 * unMetro) = dosMetros ! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:09:22'!
test09UnMetroBarraDosEsIgualAUnMedioMetro
	self assert: (unMetro / 2) = unMedioMetro! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:29:04'!
test10DiezKilometrosAnguloIzquierdoUnMetroEsVerdadero
	self assert: diezKilometros > unMetro! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:25:15'!
test11UnMetroAnguloDerechoTresMetrosEsVerdadero
	self assert: unMetro < tresMetros! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:30:45'!
test12DiezKilometrosAnguloIzquierdoIgualUnMetroEsVerdadero
	self assert: diezKilometros >= unMetro! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:33:17'!
test13UnMetroAnguloDerechoIgualTresMetrosEsVerdadero
	self assert: unMetro <= tresMetros! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:33:55'!
test14UnMetroToTresMetrosEsIntervalo
	|intervalo|
	intervalo := unMetro to: tresMetros.
	self assert: intervalo start equals: unMetro.
	self assert: intervalo end equals: tresMetros.
	self assert: intervalo size equals: 3.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:44:43'!
test15UnMetroToDiezKilometrosDeACinfoCentimetrosEsIntervalo
	|intervalo|
	intervalo := unMetro to: diezKilometros by: cincoCentimetros.
	self assert: intervalo start equals: unMetro.
	self assert: intervalo end equals: diezKilometros.
	self assert: intervalo size equals: 199981.
	! !


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


!classDefinition: #MeasureInterval category: #'Measure-Solution'!
Object subclass: #MeasureInterval
	instanceVariableNames: 'start end step'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:42:01'!
end
	^end! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:42:14'!
end: aDistance 
	end := aDistance! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:43:53'!
size
	^end amountInReferenceUnit - start amountInReferenceUnit // step amountInReferenceUnit + 1! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:42:27'!
start
	^start! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:42:33'!
start: aDistance 
	start := aDistance! !

!MeasureInterval methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:42:38'!
step: aDistance 
	step:= aDistance! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureInterval class' category: #'Measure-Solution'!
MeasureInterval class
	instanceVariableNames: ''!

!MeasureInterval class methodsFor: 'as yet unclassified' stamp: 'masch 6/7/2017 07:40:28'!
from: aMeasure to: aMeasure2 by: aMeasure3 
	^self new start: aMeasure; end: aMeasure2; step: aMeasure3; yourself! !


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
