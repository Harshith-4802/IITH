EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Connection ~ 4800 4500
Wire Wire Line
	4400 5100 4400 4500
Connection ~ 4400 4500
Wire Wire Line
	3650 5100 3400 5100
Wire Wire Line
	3400 5100 3400 4500
Wire Wire Line
	3400 4500 4400 4500
Wire Wire Line
	6600 3350 6600 2800
Wire Wire Line
	6600 2800 5650 2800
Wire Wire Line
	5650 2800 5650 3350
Wire Wire Line
	6600 3350 6450 3350
$Comp
L pspice:CAP C2
U 1 1 60267550
P 8000 4200
F 0 "C2" H 8178 4246 50  0000 L CNN
F 1 "14.88nF" H 8178 4155 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 8000 4200 50  0001 C CNN
F 3 "~" H 8000 4200 50  0001 C CNN
	1    8000 4200
	1    0    0    -1  
$EndComp
$Comp
L pspice:CAP C1
U 1 1 60268082
P 4600 5200
F 0 "C1" H 4778 5246 50  0000 L CNN
F 1 "59.52nF" H 4778 5155 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.0mm_W1.6mm_P2.50mm" H 4600 5200 50  0001 C CNN
F 3 "~" H 4600 5200 50  0001 C CNN
	1    4600 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 4500 4600 4950
Wire Wire Line
	8000 3700 8000 3950
Wire Wire Line
	2950 2850 2950 2400
Wire Wire Line
	2950 2400 2600 2400
Wire Wire Line
	2250 3400 2600 3400
Wire Wire Line
	2950 3400 2950 2950
Wire Wire Line
	1900 4500 2350 4500
Wire Wire Line
	1900 4600 2000 4600
Wire Wire Line
	2000 4600 2000 4800
Wire Wire Line
	4400 4500 4400 4000
Wire Wire Line
	4500 4000 4600 4000
Wire Wire Line
	4600 5450 4600 5600
$Comp
L power:GND #PWR04
U 1 1 60274919
P 4600 5600
F 0 "#PWR04" H 4600 5350 50  0001 C CNN
F 1 "GND" H 4605 5427 50  0000 C CNN
F 2 "" H 4600 5600 50  0001 C CNN
F 3 "" H 4600 5600 50  0001 C CNN
	1    4600 5600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 602752F5
P 2000 4800
F 0 "#PWR01" H 2000 4550 50  0001 C CNN
F 1 "GND" H 2005 4627 50  0000 C CNN
F 2 "" H 2000 4800 50  0001 C CNN
F 3 "" H 2000 4800 50  0001 C CNN
	1    2000 4800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 6027591D
P 4600 4000
F 0 "#PWR06" H 4600 3750 50  0001 C CNN
F 1 "GND" H 4605 3827 50  0000 C CNN
F 2 "" H 4600 4000 50  0001 C CNN
F 3 "" H 4600 4000 50  0001 C CNN
	1    4600 4000
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR03
U 1 1 60275DBA
P 2600 3400
F 0 "#PWR03" H 2600 3150 50  0001 C CNN
F 1 "GND" H 2605 3227 50  0000 C CNN
F 2 "" H 2600 3400 50  0001 C CNN
F 3 "" H 2600 3400 50  0001 C CNN
	1    2600 3400
	1    0    0    -1  
$EndComp
Connection ~ 2600 3400
Wire Wire Line
	2600 3400 2950 3400
$Comp
L power:VDD #PWR02
U 1 1 60276561
P 2600 2400
F 0 "#PWR02" H 2600 2250 50  0001 C CNN
F 1 "VDD" H 2615 2573 50  0000 C CNN
F 2 "" H 2600 2400 50  0001 C CNN
F 3 "" H 2600 2400 50  0001 C CNN
	1    2600 2400
	1    0    0    -1  
$EndComp
Connection ~ 2600 2400
Wire Wire Line
	2600 2400 2250 2400
Wire Wire Line
	4800 4500 5950 4500
Wire Wire Line
	6550 4500 7450 4500
$Comp
L power:GND #PWR05
U 1 1 6027EF8B
P 8000 4450
F 0 "#PWR05" H 8000 4200 50  0001 C CNN
F 1 "GND" H 8005 4277 50  0000 C CNN
F 2 "" H 8000 4450 50  0001 C CNN
F 3 "" H 8000 4450 50  0001 C CNN
	1    8000 4450
	1    0    0    -1  
$EndComp
Text Label 2150 4500 0    50   ~ 0
Vin
$Comp
L Connector_Generic:Conn_01x02 J3
U 1 1 6026B61B
P 4400 3800
F 0 "J3" H 4480 3792 50  0000 L CNN
F 1 "Conn_01x02" H 4480 3701 50  0000 L CNN
F 2 "Connector:Banana_Jack_2Pin" H 4400 3800 50  0001 C CNN
F 3 "~" H 4400 3800 50  0001 C CNN
	1    4400 3800
	0    -1   -1   0   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 6026CFB6
P 1700 4600
F 0 "J1" H 1618 4275 50  0000 C CNN
F 1 "Conn_01x02" H 1618 4366 50  0000 C CNN
F 2 "Connector:Banana_Jack_2Pin" H 1700 4600 50  0001 C CNN
F 3 "~" H 1700 4600 50  0001 C CNN
	1    1700 4600
	-1   0    0    1   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 6026E228
P 3150 2850
F 0 "J2" H 3230 2842 50  0000 L CNN
F 1 "Conn_01x02" H 3230 2751 50  0000 L CNN
F 2 "Connector:Banana_Jack_2Pin" H 3150 2850 50  0001 C CNN
F 3 "~" H 3150 2850 50  0001 C CNN
	1    3150 2850
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4069 U1
U 7 1 6026EFAE
P 2250 2900
F 0 "U1" H 2480 2946 50  0000 L CNN
F 1 "4069" H 2480 2855 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 2250 2900 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/cd40/cd4069ubms.pdf" H 2250 2900 50  0001 C CNN
	7    2250 2900
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4069 U1
U 4 1 60256B93
P 6150 3350
F 0 "U1" H 6150 3667 50  0000 C CNN
F 1 "4069" H 6150 3576 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 6150 3350 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/cd40/cd4069ubms.pdf" H 6150 3350 50  0001 C CNN
	4    6150 3350
	-1   0    0    1   
$EndComp
$Comp
L 4xxx:4069 U1
U 6 1 60253ED6
P 6250 4500
F 0 "U1" H 6250 4817 50  0000 C CNN
F 1 "4069" H 6250 4726 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 6250 4500 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/cd40/cd4069ubms.pdf" H 6250 4500 50  0001 C CNN
	6    6250 4500
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4069 U1
U 2 1 60253051
P 3950 5100
F 0 "U1" H 3950 5417 50  0000 C CNN
F 1 "4069" H 3950 5326 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 3950 5100 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/cd40/cd4069ubms.pdf" H 3950 5100 50  0001 C CNN
	2    3950 5100
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4069 U1
U 1 1 602506D3
P 2650 4500
F 0 "U1" H 2650 4817 50  0000 C CNN
F 1 "4069" H 2650 4726 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 2650 4500 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/cd40/cd4069ubms.pdf" H 2650 4500 50  0001 C CNN
	1    2650 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7450 3350 7450 3700
Wire Wire Line
	8000 3700 7450 3700
Connection ~ 7450 3700
Wire Wire Line
	7450 3700 7450 4500
Wire Wire Line
	4400 4500 4600 4500
$Comp
L 4xxx:4069 U1
U 3 1 60255324
P 5100 3350
F 0 "U1" H 5100 3033 50  0000 C CNN
F 1 "4069" H 5100 3124 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 5100 3350 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/cd40/cd4069ubms.pdf" H 5100 3350 50  0001 C CNN
	3    5100 3350
	-1   0    0    1   
$EndComp
Wire Wire Line
	4800 4500 4800 3350
Connection ~ 3400 4500
Wire Wire Line
	2950 4500 3400 4500
Wire Wire Line
	4250 5100 4400 5100
Connection ~ 5650 3350
Wire Wire Line
	5850 3350 5650 3350
$Comp
L 4xxx:4069 U1
U 5 1 6025B131
P 7150 3350
F 0 "U1" H 7150 3033 50  0000 C CNN
F 1 "4069" H 7150 3124 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm" H 7150 3350 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/Intersil/documents/cd40/cd4069ubms.pdf" H 7150 3350 50  0001 C CNN
	5    7150 3350
	-1   0    0    1   
$EndComp
Connection ~ 6600 3350
Wire Wire Line
	6850 3350 6600 3350
Connection ~ 4600 4500
Wire Wire Line
	4600 4500 4800 4500
Wire Wire Line
	5400 3350 5650 3350
Text Label 4400 4200 0    50   ~ 0
Vout
$EndSCHEMATC
