AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName		= "debugoverlay.AAWireBox"
ENT.Author			= "Raubana"
ENT.Information		= "A ball that draws a wirebox around itself based on its oriented bounding box."
ENT.Category		= "Raubana GLua Extras Examples"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= true
ENT.RenderGroup		= RENDERGROUP_OPAQUE




function ENT:Initialize()
	self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
	
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
	end
end




if SERVER then

	function ENT:Think()
		if not debugoverlay.AAWireBox then return end
		
		local pos = self:GetPos()
		local mins = self:OBBMins()
		local maxs = self:OBBMaxs()
		
		debugoverlay.AAWireBox(
			pos+mins,
			pos+maxs,
			engine.TickInterval() * 2,
			HSVToColor(
				(CurTime()%1.0)*360,
				1.0,
				1.0
			),
			true
		)
		
		self:NextThink( CurTime() )
		return true
	end
	
end