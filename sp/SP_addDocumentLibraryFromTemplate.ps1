$spWebCol = Get-SPWeb -site "http://axecmacc" -Identity "/vendors/*" -Limit ALL
$spListAdress = Get-SPWeb -site "http://axecmacc" -Identity "/templates/vendortemplate"

$spTemplates = $spListAddress.Site.GetCustomListTemplates($spListAdress)

foreach($site in $spWebCol)
{
    $site
    
    $ListPresent = $site.Lists.TryGetList("Purchase Agreements")

    if($ListPresent -ne $null)
    {
        #The list is present
        "Yes"
    }
    else
    {
        #Lists.Add("Purchase Agreements", "Purchase Agreements", $listTemplate["Purchase Agreements"])
        
        "No"
    }
}
