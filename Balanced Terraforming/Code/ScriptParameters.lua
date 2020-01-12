function OnMsg.NewHour(hour)

	--Get current terraforming values
	local currentAir = GetTerraformParam("Atmosphere")
	local currentHeat = GetTerraformParam("Temperature")
	local currentWater = GetTerraformParam("Water")
	local currentPlants = GetTerraformParam("Vegetation")
	--Calculate changes
	local airChange = floatfloor((currentPlants/2400)*(150000/(currentPlants+50000)))
	local heatChange = floatfloor((currentAir*0.7-currentHeat)/480)
	local waterChange = floatfloor((currentHeat*0.8-currentWater)/480)
	local plantsChange
	local minEnv = Min(currentAir,currentHeat,currentWater)
	if minEnv < currentPlants then
		plantsChange = floatfloor((minEnv-currentPlants)/24)
	elseif minEnv >= currentPlants then
		plantsChange = floatfloor((minEnv-currentPlants)*currentPlants/96000000)
	end
	--Apply changes
	ChangeTerraformParam("Atmosphere",airChange)
	ChangeTerraformParam("Temperature",heatChange)
	ChangeTerraformParam("Water",waterChange)
	ChangeTerraformParam("Vegetation",plantsChange)
end