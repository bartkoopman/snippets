
#Create collection of subsites which have "vendors" in site adress
$spWebCol = Get-SPWeb -site "http://axecmacc" -Identity "/vendors/*" -Limit ALL 

#Get template adress
$spListAdress = Get-SPWeb -site "http://axecmacc" -Identity "/templates/vendortemplate"
#Store array of custom templates
$spTemplates = $spListAdress.Site.GetCustomListTemplates($spListAdress)

#Loop all sites in collection
foreach($site in $spWebCol)
{
    #Save list with name "Purchase Agreements"
    $ListPresent = $site.Lists.TryGetList("Purchase Agreements")
    
    #If list has been found
    if($ListPresent -ne $null)
    {
    }
    #If not create List "Purchase Agreements" from template
    else
    {
        Lists.Add("Purchase Agreements", "Purchase Agreements", $listTemplate["Purchase Agreements"])
    }
}
