DefineClass.sBuilding_GeoPowerPlant = {
	__parents = {"RDM_GeoPowerPlant"}
}

-- DefineClass.sPart_GeoPowerPlant_Turbine = { 
	-- __parents = { "BuildingEntityClass" },
	-- entity = "sPart_GeoPowerPlant_Turbine",
-- }

-- DefineClass.sPart_GeoPowerPlant_BaseTurbine = { 
	-- __parents = { "BuildingEntityClass" },
	-- entity = "sPart_GeoPowerPlant_BaseTurbine",
-- }

-- DefineClass.sPart_GeoPowerPlant_Generator = { 
	-- __parents = { "BuildingEntityClass" },
	-- entity = "sPart_GeoPowerPlant_Generator",
-- }

-- -- @DefineClass sBuilding_GeoPowerPlant 
-- DefineClass.sBuilding_GeoPowerPlant = {
	-- __parents = { "Building", "ElectricityProducer", "BaseHeater", "Workplace", "LifeSupportConsumer" },
	
	-- properties = {
		-- { template = true, id = "effect_range", name = T{31, "Effect Range"}, editor = "number", category = "Geothermal", default = 10, min = 1, max = 20 },		
		-- { id = "work_state", name = T{34, "Work State"}, editor = "text", default = "", no_edit = false },
	-- },
	
	-- -- animation
	-- wait_working_anims_to_finish = false,
	-- anim_control_thread = false,
	-- current_state = "idle",
	
	-- building_update_time = const.HourDuration / 4,
	-- heat = 4*const.MaxHeat, -- compensate cold wave + cold area + 2 spheres
	
	-- maintenance_resource_type = "MachineParts",

	-- -- attaches
	-- turbine1 = false,
	-- turbine2 = false,
	
	-- fx_actor_class = false,
-- }

-- function sBuilding_GeoPowerPlant:GameInit()
	-- -- self.fx_actor_class = "WaterExtractor"
	-- self.fx_actor_class = "sGeoPowerPlant"
-- end

-- -- 
-- function sBuilding_GeoPowerPlant:GetHeatRange()
	-- return self.effect_range * 10 * guim
-- end

-- function sBuilding_GeoPowerPlant:GetHeatBorder()
	-- return const.SubsurfaceHeaterFrameRange
-- end

-- function sBuilding_GeoPowerPlant:GetSelectionRadiusScale()
	-- return self.effect_range
-- end

-- -- Set Animation state
-- function sBuilding_GeoPowerPlant:ChangeWorkingStateAnim(working)

	-- working = working or false
	
	-- if self.turbine1 == false then 
		-- local att = self:GetAttaches("sPart_GeoPowerPlant_Turbine") or empty_table
		-- self.turbine1 = att[1]
		-- self.turbine2 = att[2]
	-- end
	
	-- if IsValidThread(self.anim_control_thread) then
		-- DeleteThread(self.anim_control_thread)
	-- end
	
	-- if working then
		-- -- States order ...idle --> start --> working
		-- self.anim_control_thread = CreateGameTimeThread(function()

			-- if self.current_state ~= "start" then
				-- Sleep(self.turbine1:TimeToAnimEnd())
			-- end
			
			-- self.current_state = "start"
			-- self.turbine1:SetState("start")
			-- self.turbine2:SetState("start")
			-- PlayFX("Working", "start", self)
			
			-- Sleep(self.turbine1:TimeToAnimEnd())
			
			-- self.current_state = "working"
			-- self.turbine1:SetState("working")
			-- self.turbine2:SetState("working") -- loop anim
		
		-- end)
	-- else
		-- if self.anim_control_thread then
			-- -- States order... working --> end --> idle
			-- self.anim_control_thread = CreateGameTimeThread(function()
				-- if self.current_state ~= "end" then
					-- Sleep(self.turbine1:TimeToAnimEnd())
				-- end
				
				-- if self:IsMalfunctioned() then
					-- PlayFX("Breakdown", "start", self)
				-- end
				
				-- PlayFX("Working", "end", self)
				-- self.current_state = "end"
				-- self.turbine1:SetState("end")
				-- self.turbine2:SetState("end")
			-- end)
		-- end
	-- end

-- end

-- function sBuilding_GeoPowerPlant:SetWorkState(state)
	-- if self.work_state == state then
		-- return
	-- end

	-- self.work_state = state
		
	-- self:ApplyHeat(self.work_state == "produce")

-- end

-- function sBuilding_GeoPowerPlant:OnSetWorking(working)
	-- ElectricityProducer.OnSetWorking(self, working)
	-- Workplace.OnSetWorking(self, working)
	
	-- if working then
		-- self:SetWorkState("produce")	
	-- else 
		-- self:SetWorkState("disabled")
	-- end

-- end

-- function sBuilding_GeoPowerPlant:WorkLightsOn()
	-- self:SetSIModulation(100)
	
	-- local attaches = self:GetAttaches({"sPart_GeoPowerPlant_Generator", "sPart_GeoPowerPlant_BaseTurbine"})

	-- for k, att in ipairs(attaches) do
		-- att:SetSIModulation(100)
	-- end
-- end