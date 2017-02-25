push-location ./ColorCode.Netstandard
dotnet restore

$version = $env:APPVEYOR_BUILD_VERSION
if($version) {
    $projectJson = get-content ./project.json | convertfrom-json
    $projectJson.version = $version
    convertto-json $projectJson -depth 10 | set-content ./project.json
} else {
    Write-Warning "Won't patch 'project.json' since build is not running under AppVeyor"
}
dotnet pack -c Release -o ../artifacts
pop-location

push-location ./ColorCode.Facts
dotnet restore
dotnet test -xml ../artifacts/ColorCode.Facts.xml -maxthreads 1
pop-location

push-location ./ColorCode.AcceptanceTests
dotnet restore
dotnet test -xml ../artifacts/ColorCode.AcceptanceTests.xml -maxthreads 1
pop-location