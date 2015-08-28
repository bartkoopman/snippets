#Create collection of subsites which have "vendors" in site adress
$spWebCol = Get-SPWeb -site "****" -Identity "/vendors/*" -Limit ALL
#Get template adress
$spListAdress = Get-SPWeb -site "****" -Identity "/templates/vendortemplate"
#Store array of custom templates
$spTemplates = $spListAdress.Site.GetCustomListTemplates($spListAdress)
$Logfile = 'D:\Log\'+"SP_ACC.log"
$Webapp = Get-SPWebApplication -Identity "****" 

$LogString = "CREATED {Purchase Agreement} in subsites of $WebApp"

Write-Host $LogString

Clear-Content $Logfile

Add-Content -Path $Logfile -Value $LogString -Force

#Loop all sites in collection
foreach($site in $spWebCol)
{

    $LogTimeLine = Get-Date -Format "MM-dd-yyy_hh-mm-ss"

    #Save list with name "Purchase Agreements"
    $ListPresent = $site.Lists.TryGetList("Purchase Agreements")
    
    #If list has been found
    if($ListPresent -ne $null)
    {
        $logstring = 'false,'+$LogTimeLine+","+$site

        $ListPresent.OnQuickLaunch=$true
        $ListPresent.update()
                
        Write-Host $logString

        Add-Content -Path $Logfile -Value $LogString -Force
    }
    #If not create List "Purchase Agreements" from template
    else
    {
        $site.Lists.Add("Purchase Agreements", "Purchase Agreements", $spTemplates["Purchase Agreements"])
        
        $LogString = 'true,'+$LogTimeLine+","+$site

        $ListPresent = $site.Lists.TryGetList("Purchase Agreements")
        $ListPresent.OnQuickLaunch=$true
        $ListPresent.update()

        Write-Host $LogString

        Add-Content -Path $Logfile -Value $LogString -Force

    }
}
