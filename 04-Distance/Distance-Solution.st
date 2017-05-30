!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'unMetro dosMetros cienCentimetros milMilimetros unMedioMetro diezKilometros tresMetros cincoCentimetros meter centiMeter miliMeter kiloMeter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:21:08'!
setUp
	meter := DistanceUnit newWithConversionFactor: 1 withSymbol: 'm'.
	centiMeter := DistanceUnit newWithConversionFactor: 0.01 withSymbol: 'cm'.
	miliMeter := DistanceUnit newWithConversionFactor: 0.001 withSymbol: 'mm'.
	kiloMeter := DistanceUnit newWithConversionFactor: 1000 withSymbol: 'km'.
	unMetro := Distance newWith: 1 in: meter.
	dosMetros := Distance newWith: 2 in: meter.
	cienCentimetros := Distance newWith: 100 in: centiMeter.
	milMilimetros := Distance newWith: 1000 in: miliMeter.
	unMedioMetro := Distance newWith: 0.5 in: meter.
	diezKilometros := Distance newWith: 10 in: kiloMeter.
	tresMetros := Distance newWith: 3 in: meter.
	cincoCentimetros := Distance newWith: 5 in: centiMeter! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:17:21'!
test01UnMetroIgualUnMetro
	"self assert: unMetro = unMetro"! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 22:34:57'!
test02UnMetroMasUnMetroEsDosMetros
	self assert: (unMetro + unMetro) = dosMetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 22:37:34'!
test03UnMetroEsIgualACienCentimetros
	self assert: unMetro = cienCentimetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 22:59:55'!
test04DosMetrosMenosCienCentimetrosEsIgualAMilMilimetros
	self assert: (dosMetros - cienCentimetros) = milMilimetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:44:30'!
test05UnMetroEstrellaDosEsIgualADosMetros
	self assert: (unMetro * 2) = dosMetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:46:52'!
test06DosEstrellaUnMetroEsIgualADosMetros
	self assert: (2 * unMetro) = dosMetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:59:55'!
test07UnMetroBarraDosEsIgualAUnMedioMetro
	self assert: (unMetro / 2) = unMedioMetro! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:05:36'!
test08DiezKilometrosAnguloIzquierdoUnMetroEsVerdadero
	self assert: diezKilometros > unMetro! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:14:44'!
test09UnMetroAnguloDerechoTresMetrosEsVerdadero
	self assert: unMetro < tresMetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:18:18'!
test10DiezKilometrosAnguloIzquierdoIgualUnMetroEsVerdadero
	self assert: diezKilometros >= unMetro! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'PEP 5/22/2017 00:20:26'!
test11UnMetroAnguloDerechoIgualTresMetrosEsVerdadero
	self assert: unMetro <= tresMetros! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 19:17:01'!
test12UnMetroToTresMetrosEsIntervalo
	|intervalo|
	intervalo := unMetro to: tresMetros.
	self assert: intervalo start equals: unMetro.
	self assert: intervalo end equals: tresMetros.
	self assert: intervalo size equals: 3.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 20:12:26'!
test13UnMetroToDiezKilometrosDeACinfoCentimetrosEsIntervalo
	|intervalo|
	intervalo := unMetro to: diezKilometros by: cincoCentimetros.
	self assert: intervalo start equals: unMetro.
	self assert: intervalo end equals: diezKilometros.
	self assert: intervalo size equals: 199981.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:05:50'!
test14
	|factory|
	factory := DistanceFactory new.
	self assert: factory oneMeter equals: unMetro.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:10:56'!
test15
	|factory|
	factory := DistanceFactory new.
	self assert: factory twoMeters equals: unMetro * 2.
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:22:28'!
test16
	|factory|
	factory := DistanceFactory new.
	self assert: factory oneHundredCentimeters equals: cienCentimetros. 
	! !

!DistanceTest methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:22:43'!
test17
	|factory|
	factory := DistanceFactory new.
	self assert: factory twoHundredCentimeters equals: cienCentimetros * 2. 
	! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: 'measure unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'accessing' stamp: 'masch 5/23/2017 21:31:05'!
magnitudeInMetersEquals: aMagnitudeInMeters 
	^self measureInReferenceUnit = aMagnitudeInMeters! !

!Distance methodsFor: 'accessing' stamp: 'masch 5/23/2017 19:32:30'!
measure: aMeasure
	measure := aMeasure! !

!Distance methodsFor: 'accessing' stamp: 'PEP 5/21/2017 22:18:33'!
unit: aUnit 
	unit := aUnit! !


!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:27:02'!
* aNumber 
	^Distance newWith: (self measureInReferenceUnit * 2) in: self referenceUnit! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:31:55'!
+ aDistance 
	^Distance newWith: (measure + aDistance measure) in: self referenceUnit ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:29:03'!
- aDistance 
	^Distance newWith: (aDistance substractMagnitudeInMeters: self measureInReferenceUnit ) in: self referenceUnit! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:30:33'!
/ aNumber 
	^Distance newWith: (self measureInReferenceUnit / 2) in: self referenceUnit! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:29:46'!
< aDistance 
	^aDistance magnitudeInMetersIsGreaterThan: self measureInReferenceUnit ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:29:56'!
<= aDistance 
	^aDistance magnitudeInMetersIsGreaterOrEqualThan: self measureInReferenceUnit ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:30:26'!
= aDistance 
	^ aDistance magnitudeInMetersEquals: self measureInReferenceUnit! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:30:54'!
> aDistance 
	^aDistance magnitudeInMetersIsSmallerThan: self measureInReferenceUnit ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:30:10'!
>= aDistance 
	^aDistance magnitudeInMetersIsSmallerOrEqualThan: self measureInReferenceUnit ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'PEP 5/21/2017 23:55:18'!
adaptToInteger: aNumber andSend: aSelector
	^ self perform: aSelector with: aNumber! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:30:45'!
magnitudeInMetersIsGreaterOrEqualThan: aMagnitudeInMeters
	^self measureInReferenceUnit >= aMagnitudeInMeters! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:30:17'!
magnitudeInMetersIsGreaterThan: aMagnitudeInMeters 
	^self measureInReferenceUnit > aMagnitudeInMeters! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:29:27'!
magnitudeInMetersIsSmallerOrEqualThan: aMagnitudeInMeters 
	^self measureInReferenceUnit <= aMagnitudeInMeters! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:31:01'!
magnitudeInMetersIsSmallerThan: aMagnitudeInMeters
	^self measureInReferenceUnit < aMagnitudeInMeters! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 19:34:25'!
measure
	^measure! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:28:20'!
measureInReferenceUnit
	^measure * unit conversionFactor! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:09:07'!
referenceUnit
	^DistanceUnit newWithConversionFactor: 1 withSymbol: 'reference'! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:30:50'!
substractMagnitudeInMeters: aMagnitudeInMeters
	^aMagnitudeInMeters - self measureInReferenceUnit ! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:25:44'!
to: aDistance 
	^DistanceInterval from: self to: aDistance by: (Distance newWith: 1 in: self referenceUnit)! !

!Distance methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 20:05:29'!
to: aDistance by: aDistance2 
	^DistanceInterval from: self to: aDistance by: aDistance2! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'initialization' stamp: 'masch 5/23/2017 19:31:29'!
newWith: aMagnitude in: aUnit 
	^self new measure: aMagnitude; unit: aUnit; yourself! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:23:50'!
centiMeter
	^DistanceUnit newWithConversionFactor: 0.01 withSymbol: 'cm'.
! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:12:00'!
meter
	^DistanceUnit newWithConversionFactor: 1 withSymbol: 'm'.
! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:25:39'!
minusOneMeters
	^Distance newWith: -1 in: self meter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:25:15'!
oneCentimeter
	^Distance newWith: 1 in: self centiMeter.
! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:24:29'!
oneHundredCentimeters
	^Distance newWith: 100 in: self centiMeter.
! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:12:24'!
oneMeter
	^Distance newWith: 1 in: self meter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:24:13'!
twoHundredCentimeters
	^Distance newWith: 200 in: self centiMeter.
! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:12:39'!
twoMeters
	^Distance newWith: 2 in: self meter.! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'DHS 5/30/2017 08:13:50'!
zeroMeters
	^Distance newWith: 0 in: self meter.! !


!classDefinition: #DistanceInterval category: #'Distance-Solution'!
Object subclass: #DistanceInterval
	instanceVariableNames: 'start end step'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 19:57:58'!
end
	^end! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 19:57:07'!
end: aDistance 
	end := aDistance! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 21:31:13'!
size
	^end measureInReferenceUnit - start measureInReferenceUnit // step measureInReferenceUnit + 1! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 19:57:47'!
start
	^start! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 19:56:43'!
start: aDistance 
	start := aDistance! !

!DistanceInterval methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 19:57:29'!
step: aDistance 
	step:= aDistance! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceInterval class' category: #'Distance-Solution'!
DistanceInterval class
	instanceVariableNames: ''!

!DistanceInterval class methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 19:56:16'!
from: aDistance to: aDistance2 by: aDistance3 
	^self new start: aDistance; end: aDistance2; step: aDistance3; yourself! !


!classDefinition: #DistanceUnit category: #'Distance-Solution'!
Object subclass: #DistanceUnit
	instanceVariableNames: 'conversionFactor symbol unitSymbol'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceUnit methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 20:55:31'!
conversionFactor
	^conversionFactor! !

!DistanceUnit methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 20:54:23'!
conversionFactor: aConversionFactor 
	conversionFactor := aConversionFactor! !

!DistanceUnit methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 20:54:54'!
unitSymbol: aString 
	unitSymbol := aString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanceUnit class' category: #'Distance-Solution'!
DistanceUnit class
	instanceVariableNames: ''!

!DistanceUnit class methodsFor: 'as yet unclassified' stamp: 'masch 5/23/2017 20:53:38'!
newWithConversionFactor: aConversionFactor withSymbol: aUnitSymbol 
	^self new conversionFactor: aConversionFactor; unitSymbol: aUnitSymbol; yourself! !
