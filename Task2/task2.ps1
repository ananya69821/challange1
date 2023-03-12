$respRaw= Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -Proxy $Null -Uri "http://169.254.169.254/metadata/instance?api-version=2021-01-01"
$respJSON  | ConvertTo-Json -Depth 64


#To Get The Data for Particulater Key
$respRaw.compute | ConvertTo-Json -Depth 64
$respRaw.compute.tagsList | ConvertTo-Json -Depth 64

#some more examples
$respRaw.network | ConvertTo-Json -Depth 64
$respRaw.network.interface.ipv4 | ConvertTo-Json -Depth 64