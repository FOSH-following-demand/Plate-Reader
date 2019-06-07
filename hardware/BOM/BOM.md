#### Create BOM files for the equipment


We recommend creating different files:

<br>
- Electronic_BOM.csv: table containing all the integrated circuits(IC) necessary to populate the PCB (when one is present). We suggest using the format used by [kitspace.org](kitspace.org), so that people can easily order parts from different manufacturers.
<br>

| Reference | Qty  | Description | manufacturer  |MPN|manufacturer_1  |MPN_2|manufacturer_3  |MPN_4|manufacturer_5 |MPN_6|manufacturer_7  |MPN_8|Digikey|Mouser|RS|Newark|Farnell|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|R7; R8; R9  | 3  | 	Resistor 220 ohm 250mW through-hole   |    Yageo   |MFR-25FBF52-220R |TE Connectivity |CBT25J220R|TE Connectivity|	CFR16J220R|	Ohmite|	OD221JE|Stackpole Electronics |CF14JT220R|CF14JT220RCT-ND|279CBT25J220R|8066376|	21R0186 |	1265068|


<br>

- Mechanical_BOM.csv: Table containing all the mechanical parts necessary to build the equipment. Include here screws, printed parts, tubes, etc. See example below for fields

<br>

|part name| function  | quantity  |  obs.  |supplier|supplier number|link|
|---|---|---|---|---|---|---|
|20T GT2 Aluminium Alloy Timing Pulley with 8mm bore 7mm width | Used to drive spectrometer position| 6  |  | Bangood |  |https://www.banggood.com/10PcsPack-5mm8mm-20T-Aluminum-Alloy-Timing-Pulley-for-3D-Printer-DIY-Part-p-1407138.html?rmmds=myorder |
|5M 2GT-6mm Rubber Opening Timing Belt S2M GT2 Belt For 3D Printer|Used to drive spectrometer position|1||Bangood||https://www.banggood.com/5M-2GT-6mm-Rubber-Opening-Timing-Belt-S2M-GT2-Belt-For-3D-Printer-p-959254.html?rmmds=myorder&cur_warehouse=CN|
|10PCS GT2 Timing Belt Loop Rubber 6mm Width 2mm Pitch 150-2GT|Used to drive spectrometer position|1||Bangood||https://www.banggood.com/10PCS-GT2-Timing-Belt-Loop-Rubber-6mm-Width-2mm-Pitch-150-2GT-p-1210801.html?rmmds=myorder&cur_warehouse=CN|
|20T 5mm GT2 Timing Belt Idler Pulley With Bearing For 3D Printer|Used to drive spectrometer position|2||Bangood||https://www.banggood.com/20T-5mm-GT2-Timing-Belt-Idler-Pulley-With-Bearing-For-3D-Printer-p-1044832.html?rmmds=myorder&cur_warehouse=CN|
|Linear Motion Shaft|Used to drive spectrometer position|4||McMaster-Carr|6112K45|https://www.mcmaster.com/linear-motion-shafts|
|Corrosion-Resistant Rotary Shaft|Used to drive spectrometer position|1||McMaster-Carr|1265K66|https://www.mcmaster.com/rotary-shafts|
|Linear Mounted Ball Bearing with 6061 Aluminium Housing|Used to support spectrometer of linear shafts|2||McMaster-Carr|9338T51|https://www.mcmaster.com/linear-bearings|
|Linear Ball Bearing||2||McMaster-Carr|61205K75|https://www.mcmaster.com/linear-bearings|
<br>

- Tools_BOM.csv: table containing all tools used for the build. Pliers, hammer, etc.

<br>

|part name| function  | quantity  |  obs.  |supplier|supplier number|link|
|---|---|---|---|---|---|---|
|Nose needle Pliers  | hold components while soldering  | 1  |    regular pliers would also work   |digikey|L4VN-ND  |https://www.digikey.co.uk/product-detail/en/apex-tool-group/L4VN/L4VN-ND/8021129 |



