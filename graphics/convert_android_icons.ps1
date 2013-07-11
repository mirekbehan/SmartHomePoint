#Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Undefined

Remove-Item ..\shp-client-android\res\drawable-ldpi\* -recurse
Remove-Item ..\shp-client-android\res\drawable-mdpi\* -recurse
Remove-Item ..\shp-client-android\res\drawable-hdpi\* -recurse
Remove-Item ..\shp-client-android\res\drawable-xhdpi\* -recurse
Remove-Item ..\shp-client-android\res\drawable-xxhdpi\* -recurse

    $fileDirectory = [IO.Directory]::GetFiles(".\icons"); 
    foreach($fileName in Get-ChildItem $fileDirectory) { 
        Write-Host "Exporting file ... ($fileName)";

        $name = ($fileName.Name);

        # ldpi 0.75 mdpi 1 hdpi 1.5 xhdpi 2.0
		convert $fileName -resize 36x36 ..\shp-client-android\res\drawable-ldpi\$name
		convert $fileName -resize 48x48 ..\shp-client-android\res\drawable-mdpi\$name
		convert $fileName -resize 72x72 ..\shp-client-android\res\drawable-hdpi\$name
		convert $fileName -resize 96x96 ..\shp-client-android\res\drawable-xhdpi\$name
		convert $fileName -resize 144x144 ..\shp-client-android\res\drawable-xxhdpi\$name

    }   

