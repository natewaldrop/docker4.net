
$image='natewaldrop/sql-server-express:2019'
$versions='ltsc2019','1903','1909','2004','20H2'

foreach($version in $versions) {

    docker image build --isolation=hyperv --pull --build-arg WINVER="$version" `
      -t "$($image)-$($version)" .

    docker image push "$($image)-$($version)"
}

# TODO - improve
docker manifest create --amend $image `
 "$($image)-$($versions[0])" `
 "$($image)-$($versions[1])" `
 "$($image)-$($versions[2])" `
 "$($image)-$($versions[3])"`
 "$($image)-$($versions[4])"
 
docker manifest push $image
