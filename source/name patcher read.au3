#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico\read.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Include <Array.au3>
#include<File.au3>

;Renseignement sur le programme
$boite = MsgBox(1, "Name patcher read", "Place CAPMOD.RES in the same folder of this tool and click OK.")
If $boite = 2 Then Exit

;Cr�ation de la fen�tre de progression
ProgressOn("Name patcher read", "wait few seconds...")
ProgressSet(0, "Open CAPMOD.RES")

;Ouverture du fichier et mise dans un tableau
$fichier_a_ouvrir = "CAPMOD.RES"
$fichier = FileOpen($fichier_a_ouvrir, 16)
$tableau_fichier = StringRegExp(FileRead($fichier), '[[:xdigit:]]{2}', 3)
FileClose($fichier)
ProgressSet(50, "Processing corporation.csv")

;Declaration des variables pour les noms des entreprises
$debut_nom = 14307
$longueur_fullname = 39
$longueur_shortname = 16
$longueur_logofile = 7
$nombre_entreprise = 94
$longueur_csv = $nombre_entreprise + 1
Dim $csv[$longueur_csv] = ["FULL NAME (max 39 characters);SHORT NAME (max 17 characters);LOGOFILE"]

;Assignation de $i au d�but des noms d'entreprises
$i = $debut_nom

;R�cup�ration du noms des entreprises
For $y = 1 to $nombre_entreprise
	$ligne = ""
	;R�cup�ration du FULLNAME
	For $i = $i to $i + $longueur_fullname
		$ligne &= Chr("0x" & $tableau_fichier[$i])
	Next
	$ligne = StringStripWS($ligne, 2)
	$ligne &= ";"
	;R�cup�ration du SHORTNAME
	For $i = $i to $i + $longueur_shortname
		$ligne &= Chr("0x" & $tableau_fichier[$i])
	Next
	$ligne = StringStripWS($ligne, 2)
	$ligne &= ";"
	$i = $i + 1

	;R�cup�ration du LOGOFILE
	For $i = $i to $i + $longueur_logofile
		$ligne &= Chr("0x" & $tableau_fichier[$i])
	Next

	;Passage � l'entreprise suivante
	$i = $i + 23

	;Assignation du mot dans un tableau pour export en csv
	$csv[$y] = $ligne
Next

;Exportation du tableau dans un fichier csv
_FileWriteFromArray("corporation.csv", $csv)

;Supression de la derni�re ligne vide du csv
$csv = FileRead("corporation.csv")
$fichier = FileOpen("corporation.csv", 2)
FileWrite($fichier, StringTrimRight($csv, 2))
FileClose($fichier)
ProgressSet(70, "Processing person.csv")

;Declaration des variables pour les noms des personnes
$debut_nom = 25155
$longueur_name = 29
$longueur_code = 3
$nombre_personne = 64
$longueur_csv = $nombre_personne + 1
Dim $csv[$longueur_csv] = ["NAME = max 30 characters;CODE = FF01 to FF26 for female picture and MM01 to MM38 for male picture;TRAINING = 0 to 100;ADVERTISE = 0 to 100;R&D = 0 to 100;FARMING = 0 to 100;MANUFACTURING = 0 to 100;RETAIL = 0 to 100;RAW = 0 to 100"]

;Assignation de $i au d�but des noms de personne
$i = $debut_nom

;R�cup�ration du noms des personnes
For $y = 1 to $nombre_personne
	$ligne = ""
	;R�cup�ration du NAME
	For $i = $i to $i + $longueur_name
		$ligne &= Chr("0x" & $tableau_fichier[$i])
	Next
	$ligne = StringStripWS($ligne, 2)
	$ligne &= ";"
	;R�cup�ration du CODE
	For $i = $i to $i + $longueur_code
		$ligne &= Chr("0x" & $tableau_fichier[$i])
	Next
	$ligne &= ";"
	$i = $i + 72
	;R�cup�ration du TRAINING
	$valeur = ""
	For $i = $i to $i + 2
		If $tableau_fichier[$i] <> 0  Then $valeur &= Chr("0x" & $tableau_fichier[$i])
	Next
	$valeur = StringStripWS($valeur, 1)
	$ligne &= $valeur
	$ligne &= ";"
	;R�cup�ration du ADVERTISE
	$valeur = ""
	For $i = $i to $i + 2
		If $tableau_fichier[$i] <> 0  Then $valeur &= Chr("0x" & $tableau_fichier[$i])
	Next
	$valeur = StringStripWS($valeur, 1)
	$ligne &= $valeur
	$ligne &= ";"
	;R�cup�ration du R&D
	$valeur = ""
	For $i = $i to $i + 2
		If $tableau_fichier[$i] <> 0  Then $valeur &= Chr("0x" & $tableau_fichier[$i])
	Next
	$valeur = StringStripWS($valeur, 1)
	$ligne &= $valeur
	$ligne &= ";"
	;R�cup�ration du FARMING
	$valeur = ""
	For $i = $i to $i + 2
		If $tableau_fichier[$i] <> 0  Then $valeur &= Chr("0x" & $tableau_fichier[$i])
	Next
	$valeur = StringStripWS($valeur, 1)
	$ligne &= $valeur
	$ligne &= ";"
	;R�cup�ration du MANUFACTURING
	$valeur = ""
	For $i = $i to $i + 2
		If $tableau_fichier[$i] <> 0  Then $valeur &= Chr("0x" & $tableau_fichier[$i])
	Next
	$valeur = StringStripWS($valeur, 1)
	$ligne &= $valeur
	$ligne &= ";"
	;R�cup�ration du RETAIL
	$valeur = ""
	For $i = $i to $i + 2
		If $tableau_fichier[$i] <> 0  Then $valeur &= Chr("0x" & $tableau_fichier[$i])
	Next
	$valeur = StringStripWS($valeur, 1)
	$ligne &= $valeur
	$ligne &= ";"
	;R�cup�ration du RAW
	$valeur = ""
	For $i = $i to $i + 2
		If $tableau_fichier[$i] <> 0  Then $valeur &= Chr("0x" & $tableau_fichier[$i])
	Next
	$valeur = StringStripWS($valeur, 1)
	$ligne &= $valeur

	$i = $i + 2

	;Assignation du mot dans un tableau pour export en csv
	$csv[$y] = $ligne
Next

;Exportation du tableau dans un fichier csv
_FileWriteFromArray("person.csv", $csv)

;Supression de la derni�re ligne vide du csv
$csv = FileRead("person.csv")
$fichier = FileOpen("person.csv", 2)
FileWrite($fichier, StringTrimRight($csv, 2))
FileClose($fichier)

;Fin de la fen�tre de progression
ProgressSet(100, "Done", "Complete")
Sleep(500)
ProgressOff()

;Message de r�ussite
MsgBox(0, "Export Done", "Export of corporation.csv and person.csv successfull in same directory of this tool.")