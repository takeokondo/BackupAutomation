$tasks =
@{
    Source = "Music"
    Destination = "Music"
},
@{
    Source = "Pictures"
    Destination = "Pictures"
},
@{
    Source = "Documents"
    Destination = "Documents"
},
@{
    Source = "Archive"
    Destination = "Archive"
}

NET USE \\qnap\home\FallenGameR /USER:admin admin
$destinationRoot = "\\qnap\home\FallenGameR\Bogardan\2015-1st"
$creationNeeded = -not (Test-Path $destinationRoot)

foreach( $task in $tasks )
{
    $params = @()
    $params += $task.Source
    $params += Join-Path $destinationRoot $task.Destination
    if( $creationNeeded )
    {
        $params += "/CREATE"    # minimize directory fragmentation when you copy a large tree for the first time.
    }
    else
    {
        $params += "/ETA"       # Shows estimated time of completion for copied files.
    }
    $params += "/MIR"           # Mirrors a directory tree (equivalent to running both /E and /PURGE)
    $params += "/ZB"            # Tries to copy files in restartable mode , but if that fails with an “Access Denied” error, switches automatically to Backup mode.
    $params += "/LOG+:robocopy.log" # redirects output to the specified file, appending it to the file if it already exists.
    $params += "/TEE"           # Displays output in the console window, in addition to directing it to the log file specified by /LOG or /LOG+.
    robocopy $params
}

NET USE \\qnap\home\FallenGameR /DEL

