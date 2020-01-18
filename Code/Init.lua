function OnMsg.ClassesBuilt() RDM_ModGeoThermalPower:Init() end
function OnMsg.RDM_FixerThrowFixes(Fixer) 
	Fixer:FixIconUpgradePath("RDM_GeoPowerPlant", 1)
end

-- @Class sMod_GeoThermalPower
-- ===================================================================================
DefineClass.RDM_ModGeoThermalPower = {
	__parents = { "RDM_ModBase" },
	ModID = "KFWTQp4", -- SET

	techs = {"RDM_MartianGeothermalGenerator"},
	buildings = {"RDM_GeoPowerPlant"},
	upgrades = {"RDM_GeoPowerPlant_AdvancedTurbine"},
	
}
-- Set Locks/Unlocks rules
function RDM_ModGeoThermalPower:Init()
	RDM_ModBase.Init(self)
	
	self.rules_buildings = { 
		{self.buildings[1], self.techs[1]},
	}
	RDM_AddBuildingRules(self.rules_buildings)
	
	self.rules_upgrades = { 
		{self.upgrades[1], self.techs[1]},
	}
	RDM_AddUpgradeRules(self.rules_upgrades)
end

function OnMsg.TechResearched(tech_id, city, first_time)
	RDM_LockUnlock("RDM_ModGeoThermalPower", tech_id)
end