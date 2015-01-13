if (!(Test-Path .\template.json)) 
{
	write-host "templete not found"  -ForegroundColor Red
}
else 
{
	#Use ARM cmdlets
	Switch-AzureMode -Name AzureResourceManager
	CLS

	#Random
	#Used to randomize the names of the resources being created to avoid conflicts
	$Random1 = [system.guid]::NewGuid().tostring().substring(0,5)
	$Random2 = [system.guid]::NewGuid().tostring().substring(0,5)

	#Resource Group Properties
	$RG_Name = "EasyAuthDemo" + $Random1
	$RG_Location = "West Us"

	#Web Hosting Plan Properties
	$WHP_Name = "WHP" + $Random2

	#Website Properties
	$WS_Name = "EasyAuthDemo" +  $Random2
	
	#Provition Resources From Template
	#This will create:
	#		Create a Resource Group, 
	#		Creat a WebHostingPlan (WHP)
	#		Create a Website and assign it to the WHP
    #		Create a Website Slot under the Website

	Write-Host "Creating Resource Group, Web Hosting Plan, Sites and Slots..." -ForegroundColor Green 
	try 
	{ 
		New-AzureResourceGroup -name $RG_Name -location $RG_Location -TemplateFile .\template.json -resourceLocation $RG_Location -whp $WHP_Name -siteName $WS_Name
		[System.Console]::Beep(400,1500)
	}
	catch 
	{
    	Write-Host $Error[0] -ForegroundColor Red 
    	exit 1 
	} 
	pause
}