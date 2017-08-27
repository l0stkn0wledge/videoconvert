   $outputExtension = ".mp4"
   
   foreach($inputFile in get-childitem -recurse -Filter *.ts)
   { 
     $outputFileName = [System.IO.Path]::GetFileNameWithoutExtension($inputFile.FullName) + $outputExtension;
     $outputFileName = $outputFileName -replace ',','.' 
     $outputFileName = [System.IO.Path]::Combine($inputFile.DirectoryName, $outputFileName);
     
     $programFiles = ${env:ProgramFiles};
     if($programFiles -eq $null) { $programFiles = $env:ProgramFiles; }
     
     $processName = $programFiles + "\Handbrake\HandbrakeCLI.exe"
     $processArgs = "--preset-import-file .\hq1080p.json -i `"$($inputFile.FullName)`" -o `"$outputFileName`""
   
     start-process $processName $processArgs -wait
   }