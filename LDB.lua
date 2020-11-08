local a_name, a_env = ...
if not a_env.load_this then return end

local qtip = LibStub("LibQTip-1.0")
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")

local counter = 1

local dataobj = ldb:NewDataObject(a_env.basename, {
   label = a_env.basename,
   type = "data source",
   text = counter
})

local tooltip
local tooltip_outdated = true

local function AcquireTooltip(self)
   print("acquiring tooltip")
   GameTooltip:SetOwner(self, "ANCHOR_NONE")
   GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
   tooltip = GameTooltip
   tooltip_outdated = true
end

local function RegenerateTooltip(self, tooltip)
   if not tooltip_outdated then return true end
   print("regenerating tooltip")
   tooltip:ClearLines()
   -- ...
   tooltip_outdated = false
end

function dataobj:OnEnter()
   if not tooltip then AcquireTooltip(self) end
   if tooltip_outdated then RegenerateTooltip(self, tooltip) end
   tooltip:Show()
end

function dataobj:OnLeave()
   tooltip:Hide()
   tooltip = nil
end

function GLDB_SKL_Update()
   counter = counter + 1
end