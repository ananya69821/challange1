$stringData = Read-Host "Please enter the json Object" | ConvertFrom-JSON
$key = Read-Host "Please enter the Key Value"
$stringData.$key | ConvertTo-JSON
function foo {

    [CmdletBinding()] #<<-- This turns a regular function into an advanced function
    param (
        $stringData
    )

	return $strinData.$key | ConvertTo-JSON

}
foo



