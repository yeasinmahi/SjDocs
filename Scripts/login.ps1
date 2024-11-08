Write-Host '---------System Login---------'
Write-Host '	1. SIT'
Write-Host '	2. BETA'
Write-Host '	3. PROD'
Write-Host '	4. TSYS'
Write-Host ''

# Getting user's input
$selectedOption = Read-Host 'Select the system you want to login '
Write-Host ''

$numberRegex = '^[0-9]+$'
if ($selectedOption -notmatch $numberRegex) {
    Write-Host "error: Invalid selection. Not a number" -ForegroundColor Red
    exit 1
}

switch ($selectedOption) {
    1 {
        Write-Host 'You have selected 1. Going to login SIT JumpHost [20.205.209.58]. Please wait for a few seconds..'
        ssh -i C:/Users/Yeasin/.ssh/id_rsa yeasin@budokan.southeastasia.cloudapp.azure.com
    }
    2 {
        Write-Host 'You have selected 2. Going to login BETA JumpHost [40.127.99.86]. Please wait for a few seconds..'
        ssh -i C:/Users/Yeasin/.ssh/uat_id_rsa shugangl@40.127.99.86
    }
    3 {
        Write-Host 'You have selected 3. Going to login PROD JumpHost [138.91.51.52]. Please wait for a few seconds..'
        ssh -i C:/Users/Yeasin/.ssh/dpdhl_dt_id_rsa shugangl@138.91.51.52 -o ServerAliveInterval=5
    }
    4 {
        Write-Host 'You have selected 4. Going to login TSYS JumpHost [40.69.205.158]. Please wait for a few seconds..'
        ssh -i C:/Users/Yeasin/.ssh/dpdhl_dt_id_rsa simonc@40.69.205.158 -o ServerAliveInterval=5
    }
    Default {
        Write-Host "error: You have selected an option which is not in the list - $selectedOption" -ForegroundColor Red
    }
}
