-- See LICENSE for terms
local Agarast_BalanceMod = false

-- This code is executed when the game classes are built.
function OnMsg.ClassesBuilt()
	--Loading the values set in Values.lua
	local modTable = Agarast.modTable

	--When only need to do this once
	if Agarast_BalanceMod then
		return
	end

	--We'll loop through all the buildings. kb is the current building name. vb is the current changes to apply to that building.
	for kb,vb in pairs(modTable) do
		--We check that the building actually exist in the game. Even if you make a typo on 1 building, all the other changes will still apply.
		if BuildingTemplates[kb] and ClassTemplates.Building[kb] then
			--We get the current state of the building.
			local tempBuildingTemplates = BuildingTemplates[kb]
			--We are now looping through all the different changes to apply to that one building.
			for kp, vp in pairs(vb) do
				--We get the actual value of the attribute we want to modify. If it doesn't exist, we take 0 instead.
				local valueToMod = tempBuildingTemplates[kp] or 0
				--We apply the modification to both Building Templates..
				tempBuildingTemplates[kp] = modTable[kb][kp]
				--.. and ClassTemplates
				ClassTemplates.Building[kb][kp] = modTable[kb][kp]
				--Simple log if you want to check if everything is ok.
				print("Modified "..kb.." "..kp.." from "..valueToMod.." to "..modTable[kb][kp])
			end
		end
	end

	--Everything is now correctly done
	Agarast_BalanceMod = true

end

-- We still need to apply those settings on existing bulidings when loading a saved game.
function OnMsg.LoadGame()
	--Loading the values set in Values.lua
	local modTable = Agarast.modTable

	--Again, we check that we loaded the value. 
	--We don't save that in a global value like on the previous function because we want to run it everytime we load a saved game,
	--even if we quit to main menu and load another one.
	if UICity.BalanceMod_ValuesSet then
		return
	end

	--Again, looping through all the buildings types
	for kb, vb in pairs(modTable) do
		--Get all the buildings of the current type to modify
		local tempObjs = UICity.labels[kb] or ""
		--Looping through the existing buildings of the current type
		for i = 1, #tempObjs do
			--Selecting the current building
			local tempObj = tempObjs[i]
			--Looping through the modifications to apply
			for kp, vp in pairs(vb) do 
				--Applying the modificaitons
				tempObj[kp] = vp
			end
		end
	end

	--Everything is done, we can set that on true
	UICity.BalanceMod_ValuesSet = true
end