--options
local mintime = 1
local maxtime = 5
local animation_offset = 0x1E0
--/options


local PlayerGuid = UnitGUID("player")
local PlayerObject = ObjectPointer("player")

SLASH_fish = '/fish'

local function spelltoName(spellID)
	return tostring(select(1,GetSpellInfo(spellID)))
end

local function getBobber()
	local BobberName = "Fishing Bobber"
	local Total = ObjectCount(TYPE_GAMEOBJECT)
	local BobberDescriptor = nil
	
	for i = 1, Total,1 do
		local Object = ObjectWithIndex(i)
		local ObjectName = ObjectName(ObjectPointer(Object))

		if ObjectName == BobberName then
				return Object
		end

	end
end

local function isBobbing()
	local bobbing = ObjectField(getBobber(),animation_offset,SInt)
	if bobbing == 1 then
		return true
	else
		return false
	end
end

local function goFish()
	local BobberObject = getBobber()
	if BobberObject then
		if isBobbing() == true then
			print("|cffff6060[|r|cFF00FFFFFishbot|cffff6060]|r I got a fish !")
			ObjectInteract(getBobber())
		end
	else
		CastSpellByName(spelltoName(131474))
	end
end


local BobberFrame = CreateFrame("FRAME", "FishingFrame")
 BobberFrame:SetScript("OnUpdate", function(self, elapsed)
     if self.TimeSinceLastUpdate == nil then self.TimeSinceLastUpdate = 0 end
     self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
     if (self.TimeSinceLastUpdate > math.random(mintime,maxtime)) and enabled == 1 then
		 goFish()
         self.TimeSinceLastUpdate = 0
   	 end
 end)
 
 SLASH_HELLOWORLD1, SLASH_HELLOWORLD2 = '/fish', '/fishbot';

enabled = 0;

function handler(msg, editbox)
 if enabled == 1 then
  print("|cffff6060[|r|cFF00FFFFFishbot|cffff6060]|r Disabled.");
  enabled = 0;
 else
  print("|cffff6060[|r|cFF00FFFFFishbot|cffff6060]|r Enabled");
  enabled = 1;
 end
end

SlashCmdList["HELLOWORLD"] = handler;
